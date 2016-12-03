#!/bin/bash

db_image="mongo:3.0"
db_container="db" # RocketChat requires the db container to be named this
db_data="rocketchat-data"
chat_image="rocket.chat"
chat_container="rocketchat-app"

docker pull "${db_image}"
docker pull "${chat_image}"

if [[ -z "$(docker ps --all --quiet --filter=name=${db_data})" ]]; then
	echo "Creating db data container..."
	docker create --name "${db_data}" "${db_image}" --smallfiles
else
	echo "Using existing db data container."
fi

docker rm -f "${db_container}"
docker run --detach --restart always --name "${db_container}" \
	--volumes-from "${db_data}" \
	"${db_image}" \
	--smallfiles

docker rm -f "${chat_container}"
docker run --detach --restart always --name "${chat_container}" \
	-p 3000:3000 \
	--link "${db_container}" \
	"${chat_image}"

