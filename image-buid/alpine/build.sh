# build
docker build -t ricardohcaldeira/dind .

# upload to docker hub
docker push ricardohcaldeira/dind:latest

# execução — o --privileged é essencial para o daemon do Docker funcionar
#  docker run --privileged -it ricardohcaldeira/dind

# dentro do container, teste:
#docker info          # daemon rodando
#infisical --version # CLI do Infisical