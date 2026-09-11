versao=$(date +%y%m.%d%H)

# build
docker build -t ricardohcaldeira/ubuntu-dind:latest -t ricardohcaldeira/ubuntu-dind:$versao .

# upload to docker hub
docker push ricardohcaldeira/ubuntu-dind:$versao
