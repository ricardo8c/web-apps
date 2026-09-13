swarn testes no docker in docker (dind)

depends on:
[[_docker install]]

container para o swarm
```
docker run --privileged -d -p 80:80 -p 443:443 -p 9000:9000 -p 3000:3000 -v $(pwd):/projeto/app -v dind_$(basename "$(pwd)")_volumes:/projeto/volumes -v dind_$(basename "$(pwd)"):/var/lib/docker --restart unless-stopped --name $(basename "$(pwd)") docker
```

acessar o container
```
docker exec -it -w /projeto/app $(basename "$(pwd)") /bin/sh
```

parar o container
```
docker stop $(basename "$(pwd)")
```

iniciar o container
```
docker start $(basename "$(pwd)")
```

remover container/volume
```
docker rm -f $(basename "$(pwd)")
docker volume rm dind_$(basename "$(pwd)")
docker volume rm dind_$(basename "$(pwd)")_volumes
```

instalação do infisical CLI (no alpine)
```
apk add --no-cache bash sudo wget
wget -qO- 'https://artifacts-cli.infisical.com/setup.apk.sh' | sudo sh
apk update && sudo apk add infisical
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

criar a pasta dos apps
```
infisical run --env=dev --path=/web1 -- bash -c 'mkdir -p $APPS_DIR/{portainer,traefik/{rules,certs}}'
```

baixar imagens
```
docker pull portainer/agent:latest
docker pull portainer/portainer-ce:latest
docker pull traefik:v3
docker pull ghcr.io/steveiliop56/tinyauth:v5
```

inicializa o docker swarm
```
docker swarm init --advertise-addr $(hostname -i)
```

ver o tokens
```
docker swarm join-token manager
docker swarm join-token worker
```

ingressar no swarn por outros nodes
```
docker swarm join --token 09l35cbikjpi99vubvph5n1hv 192.168.15.199:2377
```

cria a rede
```
docker network create --driver=overlay --attachable --subnet 172.99.0.0/16 --gateway 172.99.0.1 proxy
docker network create --driver overlay --attachable --subnet 172.100.0.0/16 --gateway 172.100.0.1 proxy2
```

deploy do portainer
```
infisical run --env=dev --path=/web1 -- docker stack deploy --prune --resolve-image always -c ./portainer.yaml portainer
```

remove o portainer
```
docker stack rm portainer
#docker volume rm portainer
```


deploy do traefik
```
infisical run --env=dev --path=/web1 --path=/web1/tinyauth --path=/web1/traefik -- docker stack deploy --prune --resolve-image always -c ./traefik.yaml traefik
```

