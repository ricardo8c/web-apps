FROM docker:latest

# instalar tools
RUN apk add navi skim curl bash nano

# instalar infisical
RUN apk add --no-cache bash sudo wget \
    && wget -qO- 'https://artifacts-cli.infisical.com/setup.apk.sh' | sudo sh \
    && apk update \
    && sudo apk add infisical