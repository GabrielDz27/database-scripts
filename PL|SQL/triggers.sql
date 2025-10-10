	
CREATE OR REPLACE TRIGGER T_VLPRECO_HIST
AFTER UPDATE OF prd_valor ON produtos
FOR EACH ROW
WHEN (OLD.prd_valor != NEW.prd_valor)
BEGIN
    INSERT INTO historico_precos
        (prd_codigo, data, prd_preco_antigo, prd_preco_novo, usuario_sistema)
    VALUES
        (:OLD.prd_codigo, SYSDATE, :OLD.prd_valor, :NEW.prd_valor, USER);

    dbms_output.put_line('FOI SALVO NO HISTORICO');
END;


--
create or replace trigger tgg_historico_produtos_excluidos 
after delete on produtos
FOR EACH ROW
begin 
    INSERT INTO historico_produtos_excluidos VALUES (
    	:OLD.PRD_CODIGO,
    	:OLD.prd_descricao,
    	:OLD.prd_qtd_estoque,
    	:OLD.prd_valor,
    	SYSDATE,
    USER
    
    );
	dbms_output.put_line(' Usuario ' || user);
	dbms_output.put_line(' Data' || sysdate);
end;

DELETE PRODUTOS WHERE PRD_CODIGO = 1

--
CREATE OR REPLACE TRIGGER tgg_atualiza_faltaDeProduto
AFTER UPDATE ON produtos
FOR EACH ROW
BEGIN

    INSERT INTO produtos_atualizados (
        prd_codigo,
        prd_dt_atualizacao,
        prd_qtd_anterior,
        prd_qtd_atualizada,
        prd_valor
    ) VALUES (
        :OLD.prd_codigo,
        SYSDATE,
        :OLD.prd_qtd_estoque,
        :NEW.prd_qtd_estoque,
        :NEW.prd_valor
    );

    IF :NEW.prd_qtd_estoque = 0 THEN
        INSERT INTO produtos_em_falta (
            prd_codigo,
            prd_dt_falta,
            prd_qtd_estoque,
            prd_falta,
            prd_descricao,
            prd_status
        ) VALUES (
            :OLD.prd_codigo,
            SYSDATE,
            :OLD.prd_qtd_estoque,
            :NEW.prd_qtd_estoque,
            :OLD.prd_descricao,
            NULL
        );

            UPDATE produtos
        SET prd_status = NULL
        WHERE prd_codigo = :OLD.prd_codigo;

    
        UPDATE orcamentos_produtos
        SET orp_status = NULL
        WHERE orc_codigo = :OLD.prd_codigo;
    END IF;
END;

--
CREATE OR REPLACE TRIGGER tgg_vendido
AFTER INSERT ON ITEMPEDIDO
FOR EACH ROW
BEGIN
    UPDATE PRODUTO p
    SET p.quantidade_estoque = p.quantidade_estoque - :NEW.quantidade
    WHERE p.codpedido = :NEW.codpedido;
END;

--
CREATE OR REPLACE TRIGGER trg_log_estoque_insuficiente
AFTER INSERT ON ITEMPEDIDO
FOR EACH ROW
DECLARE
    v_qtd_estoque PRODUTO.quantidade_estoque%TYPE;
BEGIN
    SELECT quantidade_estoque
    INTO v_qtd_estoque
    FROM PRODUTO
    WHERE codproduto = :NEW.codproduto;

    IF :NEW.quantidade > v_qtd_estoque THEN
        INSERT INTO LOG (codlog, data, descricao)
        VALUES (LOG_SEQ.NEXTVAL, SYSDATE,
                'Produto ' || :NEW.codproduto || ' sem quantidade suficiente no estoque');
    END IF;
END;

--
CREATE OR REPLACE TRIGGER trg_log_pedido_valor
AFTER INSERT ON PEDIDO
FOR EACH ROW
DECLARE
    v_nome CLIENTE.nome%TYPE;
    v_cpf CLIENTE.cpf%TYPE;
BEGIN
    SELECT nome, cpf
    INTO v_nome, v_cpf
    FROM CLIENTE
    WHERE codcliente = :NEW.codcliente;

    IF :NEW.valortotal > 1000 THEN
        INSERT INTO LOG (codlog, data, descricao)
        VALUES (LOG_SEQ.NEXTVAL, SYSDATE,
                'Pedido acima de 1000. Valor: ' || TO_CHAR(:NEW.valortotal,'9999.99') ||
                ' | Cliente: ' || v_nome || ' | CPF: ' || v_cpf);
    END IF;
END;

--
CREATE OR REPLACE TRIGGER trg_valida_nascimento
BEFORE INSERT ON CLIENTE
FOR EACH ROW
BEGIN
    IF :NEW.datanascimento > SYSDATE THEN
        DBMS_OUTPUT.PUT_LINE(-20001, 'Data de nascimento não pode ser no futuro!');
    END IF;
END;


--
CREATE OR REPLACE TRIGGER trg_prefixo_nome_cliente
BEFORE INSERT ON CLIENTE
FOR EACH ROW
BEGIN
    IF MONTHS_BETWEEN(SYSDATE, :NEW.datanascimento) / 12 > 30 THEN
        :NEW.nome := 'Sr ' || :NEW.nome;
    END IF;
END;

--
CREATE OR REPLACE VIEW vw_matriculas_detalhadas AS
SELECT m.matricula_id,
       a.nome AS aluno,
       c.nome AS curso,
       c.idioma,
       c.nivel,
       u.nome AS unidade,
       m.status,
       m.data_matricula
FROM matriculas m
JOIN alunos a ON m.aluno_id = a.aluno_id
JOIN cursos_unidade cu ON m.curso_unidade_id = cu.curso_unidade_id
JOIN cursos c ON cu.curso_id = c.curso_id
JOIN unidades u ON cu.unidade_id = u.unidade_id;

--
CREATE OR REPLACE VIEW vw_cursos_por_unidade AS
SELECT c.nome AS curso,
       u.nome AS unidade,
       c.idioma,
       c.nivel,
       cu.horario
FROM cursos_unidade cu
JOIN cursos c ON cu.curso_id = c.curso_id
JOIN unidades u ON cu.unidade_id = u.unidade_id;

--
CREATE OR REPLACE VIEW vw_alunos_por_curso_unidade AS
SELECT c.nome AS curso,
       u.nome AS unidade,
       COUNT(m.aluno_id) AS total_alunos
FROM matriculas m
JOIN cursos_unidade cu ON m.curso_unidade_id = cu.curso_unidade_id
JOIN cursos c ON cu.curso_id = c.curso_id
JOIN unidades u ON cu.unidade_id = u.unidade_id
GROUP BY c.nome, u.nome;


--
CREATE OR REPLACE VIEW vw_alunos_multimatricula AS
SELECT a.aluno_id,
       a.nome,
       COUNT(m.matricula_id) AS qtd_matriculas
FROM alunos a
JOIN matriculas m ON a.aluno_id = m.aluno_id
GROUP BY a.aluno_id, a.nome
HAVING COUNT(m.matricula_id) > 1;

--
CREATE OR REPLACE VIEW vw_matriculas_recentes AS
SELECT a.nome AS aluno,
       a.telefone,
       c.nome AS curso,
       u.nome AS unidade,
       m.data_matricula
FROM matriculas m
JOIN alunos a ON m.aluno_id = a.aluno_id
JOIN cursos_unidade cu ON m.curso_unidade_id = cu.curso_unidade_id
JOIN cursos c ON cu.curso_id = c.curso_id
JOIN unidades u ON cu.unidade_id = u.unidade_id
WHERE m.data_matricula >= (SYSDATE - 7);

--
CREATE OR REPLACE TRIGGER trg_auditoria_matriculas
AFTER INSERT ON matriculas
FOR EACH ROW
BEGIN
   INSERT INTO log_matriculas (log_id, aluno_id, curso_unidade_id, acao)
   VALUES (SEQ_LOG_MATRICULAS.NEXTVAL, :NEW.aluno_id, :NEW.curso_unidade_id, 'INSERIDO');
END;
CREATE SEQUENCE SEQ_LOG_MATRICULAS START WITH 1 INCREMENT BY 1;

--
CREATE OR REPLACE TRIGGER trg_status_automatico
BEFORE INSERT ON matriculas
FOR EACH ROW
BEGIN
   IF :NEW.data_matricula < TRUNC(SYSDATE) THEN
      :NEW.status := 'concluida';
   END IF;
END;

--
CREATE OR REPLACE TRIGGER trg_impede_matricula_duplicada
BEFORE INSERT ON matriculas
FOR EACH ROW
DECLARE
   v_count INTEGER;
BEGIN
   SELECT COUNT(*) INTO v_count
   FROM matriculas
   WHERE aluno_id = :NEW.aluno_id
     AND curso_unidade_id = :NEW.curso_unidade_id;

   IF v_count > 0 THEN
      RAISE_APPLICATION_ERROR(-20010, 'Aluno já está matriculado neste curso/unidade!');
   END IF;
END;

--
CREATE OR REPLACE TRIGGER trg_resumo_insert
AFTER INSERT ON matriculas
FOR EACH ROW
BEGIN
   MERGE INTO resumo_cursos r
   USING (SELECT :NEW.curso_unidade_id AS id FROM dual) src
   ON (r.curso_unidade_id = src.id)
   WHEN MATCHED THEN
      UPDATE SET total_matriculados = total_matriculados + 1
   WHEN NOT MATCHED THEN
      INSERT (curso_unidade_id, total_matriculados)
      VALUES (:NEW.curso_unidade_id, 1);
END;

--
CREATE OR REPLACE TRIGGER trg_limite_alunos
BEFORE INSERT ON matriculas
FOR EACH ROW
DECLARE
   v_total INTEGER;
BEGIN
   SELECT COUNT(*) INTO v_total
   FROM matriculas
   WHERE curso_unidade_id = :NEW.curso_unidade_id;

   IF v_total >= 3 THEN
      RAISE_APPLICATION_ERROR(-20011, 'Limite de 3 alunos por curso/unidade atingido!');
   END IF;
END;

--
CREATE OR REPLACE TRIGGER tgg_vendido
AFTER INSERT ON ITEMPEDIDO
FOR EACH ROW
BEGIN
    UPDATE PRODUTO p
    SET p.quantidade_estoque = p.quantidade_estoque - :NEW.quantidade
    WHERE p.codpedido = :NEW.codpedido;
END;


--

CREATE OR REPLACE TRIGGER trg_log_estoque_insuficiente
AFTER INSERT ON ITEMPEDIDO
FOR EACH ROW
DECLARE
    v_qtd_estoque PRODUTO.quantidade_estoque%TYPE;
BEGIN
    SELECT quantidade_estoque
    INTO v_qtd_estoque
    FROM PRODUTO
    WHERE codproduto = :NEW.codproduto;

    IF :NEW.quantidade > v_qtd_estoque THEN
        INSERT INTO LOG (codlog, data, descricao)
        VALUES (LOG_SEQ.NEXTVAL, SYSDATE,
                'Produto ' || :NEW.codproduto || ' sem quantidade suficiente no estoque');
    END IF;
END;

--
CREATE OR REPLACE TRIGGER trg_log_pedido_valor
AFTER INSERT ON PEDIDO
FOR EACH ROW
DECLARE
    v_nome CLIENTE.nome%TYPE;
    v_cpf CLIENTE.cpf%TYPE;
BEGIN
    SELECT nome, cpf
    INTO v_nome, v_cpf
    FROM CLIENTE
    WHERE codcliente = :NEW.codcliente;

    IF :NEW.valortotal > 1000 THEN
        INSERT INTO LOG (codlog, data, descricao)
        VALUES (LOG_SEQ.NEXTVAL, SYSDATE,
                'Pedido acima de 1000. Valor: ' || TO_CHAR(:NEW.valortotal,'9999.99') ||
                ' | Cliente: ' || v_nome || ' | CPF: ' || v_cpf);
    END IF;
END;

--
CREATE OR REPLACE TRIGGER trg_valida_nascimento
BEFORE INSERT ON CLIENTE
FOR EACH ROW
BEGIN
    IF :NEW.datanascimento > SYSDATE THEN
        DBMS_OUTPUT.PUT_LINE(-20001, 'Data de nascimento não pode ser no futuro!');
    END IF;
END;

--
CREATE OR REPLACE TRIGGER trg_prefixo_nome_cliente
BEFORE INSERT ON CLIENTE
FOR EACH ROW
BEGIN
    IF MONTHS_BETWEEN(SYSDATE, :NEW.datanascimento) / 12 > 30 THEN
        :NEW.nome := 'Sr ' || :NEW.nome;
    END IF;
END;
