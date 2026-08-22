# web-apps

Laboratório de web apps em [Docker Swarm](https://docs.docker.com/engine/swarm/) rodando em Docker-in-Docker (dind), com [Traefik v3](https://traefik.io/) como proxy reverso, [Portainer](https://www.portainer.io/) para gerenciamento e [Infisical](https://infisical.com/) para gestão de segredos e variáveis de ambiente.

## Estrutura

```
.
├── web1/                  # stacks do ambiente "web1"
│   ├── portainer.yaml     # stack do Portainer (agent + CE)
│   └── traefik.yaml       # stack do Traefik + Tinyauth
├── exemplos/
│   └── rule.example.yml   # exemplo de regras dinâmicas do Traefik
├── web1 (dev).md          # passo a passo do ambiente dev (dind no Alpine)
└── web1 (staging).md      # passo a passo do ambiente staging (host Debian/Ubuntu)
```

## Requisitos

- Docker Engine com modo Swarm
- [Infisical CLI](https://infisical.com/docs/cli/overview) autenticado (`infisical login`) e projeto inicializado na pasta (`infisical init`)
- Variável `APPS_DIR` definida no ambiente do Infisical (ex.: `/projeto/volumes/apps`)

## Uso

O fluxo completo (criar container dind, iniciar swarm, criar redes, etc.) está documentado nos arquivos [`web1 (dev).md`](<web1 (dev).md>) e [`web1 (staging).md`](<web1 (staging).md>).

Resumo dos deploys:

```bash
# Portainer
infisical run --env=dev --path=/web1 -- \
  docker stack deploy --prune --resolve-image always -c ./portainer.yaml portainer

# Traefik
infisical run --env=dev --path=/web1 --path=/web1/tinyauth --path=/web1/traefik -- \
  docker stack deploy --prune --resolve-image always -c ./traefik.yaml traefik
```

> Ajuste `--env` conforme o ambiente (`dev` ou `staging`).

## Serviços

| Serviço   | Imagem                          | Descrição                        |
|-----------|---------------------------------|----------------------------------|
| Traefik   | `traefik:v3`                    | Proxy reverso / LB nas portas 80/443 |
| Tinyauth  | `ghcr.io/steveiliop56/tinyauth:v5` | Autenticação simples         |
| Portainer | `portainer/portainer-ce:latest` | UI de gerenciamento do Swarm     |
| Agent     | `portainer/agent:latest`        | Agente do Portainer (mode global)|
