## Setup

Install [docker](https://docs.docker.com/engine/install/ubuntu)

Install [docker-compose](https://docs.docker.com/compose/install)

`PROJECT_DIR` is project root directory.

```shell
mkdir ${PROJECT_DIR}
cd ${PROJECT_DIR}

sudo apt update -y
sudo apt install -y git make nano

git clone http://185.208.77.246/docker/monitoring.git .
# git checkout develop
 
make init
```

## Run

```shell
cd ${PROJECT_DIR}

make start
```

#### Web UI:

* Grafana: http://127.0.0.1:3000
* Prometheus: http://127.0.0.1:9090
* Alertmanager: http://127.0.0.1:9093

# authentication
grafana:
user: admin
pass: admin

## Usefull commands

```shell
make
make up
make down
make start
make restart
make logs
```
