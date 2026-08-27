#!/bin/bash
set -e

dockerd --host=unix:///var/run/docker.sock \
        --host=tcp://0.0.0.0:2376 \
        --tls=false \
        > /var/log/dockerd.log 2>&1 &
DOCKER_PID=$!

until docker info >/dev/null 2>&1; do
    if ! kill -0 "$DOCKER_PID" 2>/dev/null; then
        echo "dockerd falhou ao iniciar. Veja /var/log/dockerd.log" >&2
        cat /var/log/dockerd.log >&2
        exit 1
    fi
    echo "Aguardando dockerd..."
    sleep 1
done

echo "Docker daemon pronto"

# Mantém o container vivo enquanto o daemon estiver rodando
wait "$DOCKER_PID"