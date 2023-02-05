
Stack:
 - 1 Elasticsearch 8.2 single node mode
 - 1 Kibana
 - 1 KleverChain indexer full node
 - 1 KleverChain proxy API

This stack can be used to extend node queries. For better performance is recommended to create a ElasticSearch cluster instead of single node contained in this composer file. ElasticSearch endpoint can be updated in `external.yaml` file inside `/config/mainnet` and `/config/proxy`.

INDEXER install 

```
sudo su
sudo apt update
sudo apt upgrade
```
```
sudo reboot
```

Install docker this way : 
```
curl -fsSL https://get.docker.com | bash
```

Instal Docker Compose and update to V1.29.2
```
apt-get install docker-compose
```
```
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```
```
chmod +x /usr/local/bin/docker-compose
```
Check docker status if it is running
```
systemctl status docker
```

Make install
```
apt-get -y install make
```

Then clone the repo
```
sudo git clone https://github.com/klever-io/kleverchain-proxy.git
```
```
cd kleverchain-proxy
```

Edit node-indexer version of image
Edit docker-compose.yml and change node version from latest to 
```
v0.4.14-0-gab472bb8 
```

Add swagger where 0.0.0.0 is your own IP or domain
It is on line around 85. (#PROXY / kleverproxy)
```
   command: ["--swagger-url=0.0.0.0:8701"]
```
Example : 
```
  kleverproxy:
    image: kleverapp/klever-proxy-go:latest
    container_name: kleverproxy
    depends_on:
      es01:
        condition: service_healthy
      cache:
        condition: service_healthy
    command: ["--swagger-url=api1.kleverchain.cloud:8701"]
    ports:
      - 8701:8701
    volumes:
      - ./config/proxy:/opt/klever-proxy-go/cmd/proxy/config/
    networks:
      - klever
```

Download geo location data
```
sudo make geoloc-file
```

Create Node BLSKey
```
sudo make nodePEM
```

Set folder Database backup for spinup
```
mkdir data/db/backup
```

Set folder rights
```
chown -R 1000:0 ./data/
chown -R 1000:0 ./config/
chmod -R o+rw config/
```
To speed up syncing from start we download first the backup, keep staying in the kleverchain-proxy folder
```
curl -k https://backup.mainnet.klever.finance/kleverchain.mainnet.latest.tar.gz \    | tar -xz -C ./data/db/backup
```

To run the speed up you need to add import flag in the Node Indexer entrypoint line at the end of the line before ] 
```
 "--import-db=/opt/klever-blockchain/db/backup", "--import-db-no-sig-check",
```

looks like this : 
```
entrypoint: [ "/usr/local/bin/validator", "--log-level=*:INFO", "--log-save", "--use-log-view", "--rest-api-interface=0.0.0.0:8080", "--import-db=/opt/klever-blockchain/db/backup", "--import-db-no-sig-check",]
```

Run stack
```
sudo make composerup
```

When the speedup sync is completed then you must remove the 2 flags we added in the beginning from the docker-compose.yml
Then the indexer will sync the leftover epochs. So delete these. You need to stop the node-indexer container and the kleverproxy container, and run command make composerup again.
```
 "--import-db=/opt/klever-blockchain/db/backup", "--import-db-no-sig-check",
```