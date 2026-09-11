versao=$(date +%y%m.%d%H)

# build
docker build -t ricardohcaldeira/alpine-dind:latest -t ricardohcaldeira/alpine-dind:$versao .

# upload to docker hub
docker push ricardohcaldeira/alpine-dind:$versao
