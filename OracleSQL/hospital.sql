create table Pacientes (
    cpf smallint not null primary key,
    nome_pc varchar(50) not null,
    telefone number not null,
    nome_plano varchar(200),
    endereco varchar(500)
);


create table Medicos (
    crm smallint not null primary key,
    telefone_Md number not null,
    especialidade varchar(60),
    email char(20),
    nome_Md varchar (120)
);


create table Consultas (
    n_Consulta smallint not null primary key,
    tipo_consulta varchar (100) not null,
    data_Consulta date not null,
    id_Pc smallint not null,
    id_Md smallint not NULL,
    foreign key (id_Pc) references Pacientes (cpf),
    foreign key (id_Md) references Medicos (crm)
);


create sequence id_sequence
start with 1
increment by 1;


alter table Consultas
modify n_Consulta default id_sequence.nextval;


alter table Pacientes
modify nome_plano varchar(50) not null;




alter table Pacientes
rename column nome_pc to nome;


alter table Pacientes
add dt_nascimento DATE not null;


alter table Consultas
add situacao_consulta varchar(50)
check(situacao_consulta in ('Realizada','Cancelada','Marcada'));


-- Pode se criar uma tabela especialidades Onde vencula o id do medico
-- e o id da especialidade, como fosse um atributo composto,
-- assim sendo uma chave primaria composta


create table especialidade(
    id_esecialidade smallint not null primary key,
    descricao varchar (200) not null
);


create table EspecialidadeMedico (
    id_especialidade smallint not null,
    id_medico smallint not null,
    PRIMARY key (id_especialidade,id_medico),
    foreign key (id_medico) references medicos (crm),
    FOREIGN key (id_especialidade) references especialidade (id_esecialidade)
);


ALTER TABLE Medicos
DROP COLUMN especialidade;


alter table Consultas
add id_especialidade smallint;


ALTER TABLE Consultas
ADD CONSTRAINT FK_consultas
FOREIGN KEY (id_especialidade,id_Md)  
REFERENCES EspecialidadeMedico (id_especialidade, id_medico);




-- Criar novas tabelas para o telefone do paciente e do medico




ALTER TABLE Medicos
DROP COLUMN telefone_Md;


ALTER TABLE Pacientes
DROP COLUMN telefone;




alter table Medicos
add id_telefone smallint;




alter table Pacientes
add id_telefone smallint;




CREATE TABLE TelefonePacientes (
    id_telefone SMALLINT PRIMARY KEY,
    id_paciente SMALLINT NOT NULL,
    numero VARCHAR(15) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES Pacientes(cpf)
);


CREATE TABLE TelefoneMedicos (
    id_telefone SMALLINT PRIMARY KEY,
    id_medico SMALLINT NOT NULL,
    numero VARCHAR(15) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_medico) REFERENCES Medicos(crm)
);


ALTER TABLE medicos
ADD CONSTRAINT FK_telefoneMedico
FOREIGN KEY (id_telefone)  
REFERENCES TelefoneMedicos (id_telefone);




ALTER TABLE Pacientes
ADD CONSTRAINT FK_telefonePaciente
FOREIGN KEY (id_telefone)  
REFERENCES TelefonePacientes (id_telefone);

