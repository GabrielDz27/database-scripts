## MongoDB

MongoDB é um banco de dados NoSQL orientado a documentos, que armazenar JSON, CSV e outros formatos.
Neste pasta eu disponibilizo scripts e exemplos para manipular coleções MongoDB localmente. Para facilitar a execução, coloquei um docker-compose que sobe uma imagem do MongoDB na sua máquina; basta rodar os scripts para importar dados (CSV/JSON) e testar consultas e operações básicas.


### Pré-requisitos
- Docker instalado.
- (Opcional) mongo.

### Como iniciar

1. **Subir o container:**
   ```bash
   docker-compose up -d

2. **Conferir container mongodb-local está rodando:**
   ```bash
   docker ps

### Comandos úteis

1. **Parar o container:**
   ```bash
   docker-compose stop

2. **Limpar tudo:**
    ```bash
    docker-compose down -v