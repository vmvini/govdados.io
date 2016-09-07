#!/bin/bash

echo "preparando arquivos"

rm -rf infraestrutura/node-csv-importer/datasource.txt
rm -rf infraestrutura/postgres_alpine/tabelas

#enviar datasource para infraestrutura/node-csv-importer/
cp -R datasource.txt infraestrutura/node-csv-importer

#enviar arquivos sql para 
cp -R tabelas/* infraestrutura/postgres_alpine

#limpar arquivos extraidos
rm -rf temp
mkdir temp

echo "limpando caches do docker"

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker volume rm $(docker volume ls |awk '{print $2}')


echo "construindo imagens"

docker-compose build
docker-compose up
