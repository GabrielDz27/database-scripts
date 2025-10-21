#!/bin/bash

CONTAINER_NAME="mongodb-estudos"
DB_NAME="estudosDB"
COLLECTION_NAME="Clientes"
JSON_FILE="init/Clientes.json"

echo ">>>> Importando os dados JSON para coleção '$COLLECTION_NAME'..."

docker exec -i $CONTAINER_NAME mongoimport \
    --db $DB_NAME \
    --collection $COLLECTION_NAME \
    --type json \
    --file $JSON_FILE \
    --jsonArray \
    --drop 

echo ">>>> Finalizada a importacao com sucesso! :) "

