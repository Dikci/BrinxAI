#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Update package list and install dependencies
echo "Updating package list and installing dependencies..."
sudo apt-get update
sudo apt-get install -y curl gnupg lsb-release wget

# Check if GPU is available
echo "Checking GPU availability..."
GPU_AVAILABLE=false
if command -v nvidia-smi &> /dev/null
then
    echo "GPU detected. NVIDIA driver is installed."
    GPU_AVAILABLE=true
else
    echo "No GPU detected or NVIDIA driver not installed."
fi

# Set default WORKER_PORT to 5011
echo "Setting default WORKER_PORT to 5011..."
DEFAULT_PORT=5011

# Create .env file with default WORKER_PORT
echo "Creating .env file..."
cat <<EOF > .env
WORKER_PORT=$DEFAULT_PORT
EOF

# Create docker-compose.yml file
echo "Creating docker-compose.yml..."
if [ "$GPU_AVAILABLE" = true ]; then
    cat <<EOF > docker-compose.yml
version: '3.8'

services:
  worker:
    image: admier/brinxai_nodes-worker:latest
    environment:
      - WORKER_PORT=\${WORKER_PORT:-5011}
    ports:
      - "\${WORKER_PORT:-5011}:\${WORKER_PORT:-5011}"
    volumes:
      - ./generated_images:/usr/src/app/generated_images
      - /var/run/docker.sock:/var/run/docker.sock
    networks:
      - brinxai-network
    deploy:
      resources:
        reservations:
          devices:
            - capabilities: [gpu]
    runtime: nvidia

networks:
  brinxai-network:
    driver: bridge
    name: brinxai-network  # Explicitly set the network name
EOF
else
    cat <<EOF > docker-compose.yml
version: '3.8'

services:
  worker:
    image: admier/brinxai_nodes-worker:latest
    environment:
      - WORKER_PORT=\${WORKER_PORT:-5011}
    ports:
      - "\${WORKER_PORT:-5011}:\${WORKER_PORT:-5011}"
    volumes:
      - ./generated_images:/usr/src/app/generated_images
      - /var/run/docker.sock:/var/run/docker.sock
    networks:
      - brinxai-network

networks:
  brinxai-network:
    driver: bridge
    name: brinxai-network  # Explicitly set the network name
EOF
fi

# Start Docker containers using docker compose
echo "Starting Docker containers..."
docker compose up -d

echo "Installation and setup completed successfully."
