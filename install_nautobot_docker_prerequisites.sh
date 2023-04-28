#!/bin/bash

# give it executable permissions with 
# "chmod +x install_nautobot_docker_prerequisites.sh"
# and run it with "./install_nautobot_docker_prerequisites.sh".

# Update the package index
sudo apt-get update

# Install git
sudo apt-get install -y git

# Install the required system packages
sudo apt-get install -y python3 python3-dev python3-venv python3-pip build-essential libssl-dev libffi-dev libxml2-dev libxslt1-dev zlib1g-dev libpq-dev

echo "Python installed successfully."

# Install Docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce

echo "Docker installed successfully."

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /bin/docker-compose

echo "Docker Compose installed successfully."

# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Add the current user to the Docker group
sudo usermod -aG docker $(whoami)

# Print Docker version to verify installation
docker --version
docker-compose --version

# Clone the repository
git clone https://github.com/nautobot/nautobot-docker-compose.git

# Navigate to the new directory
cd nautobot-docker-compose

# Copy local.env.example to local.env
cp local.env.example local.env

# Update the .env to be only available for the current user
chmod 0600 local.env

# Run docker-compose up to start the environment
docker-compose up -d

# Check if .gitignore file exists
if [ ! -f .gitignore ]; then
    # Create a .gitignore file if it does not exist
    touch .gitignore

# Check if 'local.env' is already in .gitignore
if ! grep -q "local.env" .gitignore; then
    # Add 'local.env' to .gitignore
    echo "local.env" >> .gitignore
