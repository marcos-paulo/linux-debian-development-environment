#!/bin/bash

write_log_docker() {
  write_log "[Docker] $1"
}

docker_dependencies() {
  sudo apt-get update

  sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release 2>&1 | write_log
}

docker_download() {
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL "https://download.docker.com/linux/$(lsb_release -is |
    tr '[:upper:]' '[:lower:]')/gpg" |
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

}

docker_install() {
  sudo apt-get update 2>&1 | write_log
  sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-compose-plugin \
    2>&1 | write_log
}

docker_group() {
  write_log_docker "Criando grupo docker ..."
  # Add group docker
  sudo groupadd -g 137 docker

  # $(id 1000 -nu) - provide username with id 1000 / fornece o nome do usuario com id 1000
  # Add group docker to user
  USER_NAME=$(id -nu)

  write_log_docker "Adicionando grupo docker ao usuário $USER_NAME..."
  sudo usermod -aG docker $USER_NAME
}

docker_main() {
  tag_figlet "Install Docker"
  docker_dependencies
  docker_download
  docker_install
  docker_group
}

question_tag_no_figlet
confirm_question "Deseja instalar o Docker?" \
  -y "break_two_line" "docker_main" \
  -n "break_two_line"
