#!/bin/bash

sudo apt update -y && sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y

# Check if Docker is already installed
echo "=====[STEP] Checking if Docker is already installed====="
if command -v docker &> /dev/null; then
    echo "[INFO] Docker is already installed. Skipping Docker installation."
    docker --version
else
    echo "=====[STEP] Docker is not installed. Proceeding with installation====="
    
    # Installing docker
    echo "=====[STEP] Setting up Docker repository====="
    sudo apt-get install ca-certificates curl -y
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update -y

    echo "=====[STEP] Installing Docker Engine and related packages====="
    sudo DEBIAN_FRONTEND=noninteractive apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
    sudo usermod -aG docker ${USER}
    newgrp docker
    echo "=====[INFO] Docker has been successfully installed.====="
fi

# Install git
echo "=====[STEP] Installing Git====="
sudo apt-get install git -y

