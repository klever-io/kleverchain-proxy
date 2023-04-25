
Stack:
 - 1 Elasticsearch 8.2 single node mode
 - 1 Kibana
 - 1 KleverChain indexer full node
 - 1 KleverChain proxy API

This stack can be used to extend node queries. For better performance is recommended to create a ElasticSearch cluster instead of single node contained in this composer file. ElasticSearch endpoint can be updated in `external.yaml` file inside `/config/mainnet` and `/config/proxy`.

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
