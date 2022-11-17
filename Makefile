current_dir = $(shell pwd)


geoloc-file:
	curl -o ${current_dir}/config/proxy/geolocationdb.bin https://kleverchain-wasm.s3.eu-central-1.amazonaws.com/geolocationdb.bin 

nodePEM:
	docker run -it --rm -v ${current_dir}/config/mainnet:/opt/klever-blockchain --user "$(id -u):$(id -g)" --entrypoint='' kleverapp/klever-go:latest keygenerator

cleanup:
	rm -rf ${current_dir}/data/db/*
	rm -rf ${current_dir}/data/es/*
	rm -rf ${current_dir}/data/logs/*

composerup:
	docker-compose up -d

all: geoloc-file nodePEM composerup
