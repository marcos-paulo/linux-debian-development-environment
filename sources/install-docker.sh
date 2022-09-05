#!/bin/bash

write_log_docker() {
  write_log "[Docker] $1"
}

write_log_docker "Instalando Docker ..."
# Install Docker CE CLI
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/gpg | sudo apt-key add - 2>/dev/null
echo "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Install Docker Compose manualmente (não prescisa deixei só pra saber)
# DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
# mkdir -p $DOCKER_CONFIG/cli-plugins
# export LATEST_COMPOSE_VERSION=$(curl -sSL "https://api.github.com/repos/docker/compose/releases/latest" | grep -o -P '(?<="tag_name": ").+(?=")')
# sudo curl -sSL "https://github.com/docker/compose/releases/download/${LATEST_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/lib/docker/cli-plugins
# sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

write_log_docker "Criando grupo docker ..."
# Add group docker
sudo groupadd -g 137 docker

# $(id 1000 -nu) - provide username with id 1000 / fornece o nome do usuario com id 1000
# Add group docker to user
USER_NAME=$(id -nu)

write_log_docker "Adicionando grupo docker ao usuário $USER_NAME..."
sudo usermod -aG docker $USER_NAME
