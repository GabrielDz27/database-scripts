#!/bin/bash

CONTAINER_NAME="mongodb-estudos"
DB_NAME="estudosDB"
COLLECTION_NAME="Contas"
CSV_FILE="init/Contas.csv"

echo ">>>> Importando os dados CSV para coleção '$COLLECTION_NAME'..."

docker exec -i $CONTAINER_NAME mongoimport \
    --db $DB_NAME \
    --collection $COLLECTION_NAME \
    --type csv \
    --file $CSV_FILE \
    --headerline \
    --drop 

echo ">>>> Finalizada a importacao com sucesso! :) "