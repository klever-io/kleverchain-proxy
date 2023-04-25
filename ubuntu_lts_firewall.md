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
