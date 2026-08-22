ambiente pré-produção do swarn  no docker in docker (dind)

depends on:
[[_docker install]]
reference:
[[web1 (dev)]]


instalação do infisical CLI (Debian/Ubuntu)
```
curl -1sLf 'https://artifacts-cli.infisical.com/setup.deb.sh' | sudo -E bash
sudo apt-get update && sudo apt-get install -y infisical
#infisical login
```

login
```
infisical login
```

iniciar o projeto na pasta
```
infisical init
```

criar a pasta dos apps e baixar imagens
```
infisical run --env=staging --path=/web1 -- bash -c 'mkdir -p $APPS_DIR/{portainer,traefik/{rules,certs}}'
docker pull portainer/agent:latest
docker pull portainer/portainer-ce:latest
docker pull traefik:v3
docker pull ghcr.io/steveiliop56/tinyauth:v5
#images downloaded
```

inicializa o docker swarm
```
docker swarm init --advertise-addr $(hostname -i)
```

cria a rede
```
docker network create --driver=overlay --attachable --subnet 172.99.0.0/16 --gateway 172.99.0.1 proxy
docker network create --driver overlay --attachable --subnet 172.100.0.0/16 --gateway 172.100.0.1 proxy2
```

deploy do portainer
```
infisical run --env=staging --path=/web1 -- docker stack deploy --prune --resolve-image always -c web1/portainer.yaml portainer
```

deploy do traefik
```
infisical run --env=staging --path=/web1 --path=/web1/tinyauth --path=/web1/traefik -- docker stack deploy --prune --resolve-image always -c web1/traefik.yaml traefik
```



remover o portainer
```
docker stack rm portainer
#docker volume rm portainer
```
