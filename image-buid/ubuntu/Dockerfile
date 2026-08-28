FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl gnupg iptables supervisor kmod \
    && rm -rf /var/lib/apt/lists/*

# Instala fzf
RUN apt-get update && apt-get install -y fzf

# Instala navi
RUN bash -c 'bash <(curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)'

# Move o binario do navi
RUN mv /root/.cargo/bin/navi /usr/local/bin/

# Instala o infisical
RUN curl -1sLf 'https://artifacts-cli.infisical.com/setup.deb.sh' | bash \
    && apt-get update && apt-get install -y infisical

# Instala Docker CE (engine + CLI + containerd)
RUN install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && chmod a+r /etc/apt/keyrings/docker.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" \
       > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io \
    && rm -rf /var/lib/apt/lists/*

# Wrapper que inicia o daemon e mantém o container vivo
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
