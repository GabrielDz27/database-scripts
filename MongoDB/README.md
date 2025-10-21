## MongoDB

MongoDB é um banco de dados NoSQL orientado a documentos, que armazenar JSON, CSV e outros formatos.
Neste pasta eu disponibilizo scripts e exemplos para manipular coleções MongoDB localmente. Para facilitar a execução, coloquei um docker-compose que sobe uma imagem do MongoDB na sua máquina; basta rodar os scripts para importar dados (CSV/JSON) e testar consultas e operações básicas.

### Obs:
Vou deixar um arquivo basicoComandos.js com poucos comandos para testar o mongoDB 

### Pré-requisitos
- Docker instalado.
- (Opcional) mongo.

### Arquivos para importação
Os arquivos estão dentro da pasta /init 
- Clientes.json
- Contas.csv

### Como iniciar

1. **Subir o container:**
   ```bash
   docker-compose up -d 

2. **Conferir container mongodb-local está rodando:**
   ```bash
   docker ps

3. **Comandos para importar os dados e criar as coleçoes:**
   ```bash
   sh scripts/import_clientes.sh
   sh scripts/import_contas.sh

## Testando acessando o shell
Testes fica a sua preferencia qual local, vou deixar alguns scripts basicos:
      ```bash
      docker exec -it mongodb-estudos mongosh

      show dbs

      use estudosDB

      show collections

### Comandos úteis

1. **Parar o container:**
   ```bash
   docker-compose stop

2. **Limpar tudo:**
    ```bash
    docker-compose down -v