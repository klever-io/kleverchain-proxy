## Installation preparations
```
sudo su
sudo apt update
sudo apt upgrade
```
```
sudo reboot
```

### Install docker
```curl -fsSL https://get.docker.com | bash```

### Install docker-compose
```apt-get install docker-compose```

### Check docker status
```systemctl status docker```

### Update to docker compose 1.29
```curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose```
```chmod +x /usr/local/bin/docker-compose```

### Install Make
```apt-get -y install make```
