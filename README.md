
Stack:
 - 1 Elasticsearch 8.2 single node mode
 - 1 Kibana
 - 1 KleverChain indexer full node
 - 1 KleverChain proxy API

This stack can be used to extend node queries. For better performance is recommended to create a ElasticSearch cluster instead of single node contained in this composer file. ElasticSearch endpoint can be updated in `external.yaml` file inside `/config/mainnet` and `/config/proxy`.

### Update to docker compose 1.29
```curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose```
```chmod +x /usr/local/bin/docker-compose```

### Install Make
```apt-get -y install make```

### Clone Repository
```git clone https://github.com/klever-io/kleverchain-proxy.git```

```cd kleverchain-proxy```

### Download geo location data
```make geoloc-file```

### Create Node BLSKey
```make nodePEM```

### Set folder rights
```
chown -R 1000:0 ./data/
chown -R 1000:0 ./config/
chmod -R o+rw config/
```

### Run Stack
```make composerup```

## Edit firewall on Ubuntu

#### Allow ssh for terminal
```sudo ufw allow ssh```
#### Enable firewall logging (optional)
```sudo ufw logging on```
#### Klever-Node communication
```ufw allow 37373:38383/tcp```
#### Node-API (optional)
```ufw allow 8080/tcp```
#### Swagger-API
```ufw allow 8701/tcp```

### Enable firewall
```sudo ufw enable```

```ufw status```
