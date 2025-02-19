#!/bin/bash

# Define colors for text
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
RESET='\033[0m'  # Reset color

# Display LearnFastEarn Banner with Colors
echo -e "${CYAN}***************************************"
echo -e "*                                     *"
echo -e "*      ${MAGENTA}LearnFastEarn Info${CYAN}        *"
echo -e "*                                     *"
echo -e "***************************************"
echo -e "Don't forget to check out our official channels:"
echo -e "📱 Telegram: ${YELLOW}https://t.me/LearnFastEarn4All${RESET}"
echo -e "🎥 YouTube: ${YELLOW}https://www.youtube.com/@LearnFastEarn2.0${RESET}"
echo -e "💻 GitHub Repo: ${YELLOW}https://github.com/zulfi125/${RESET}"
echo ""
echo -e "${CYAN}***************************************"
echo -e "*                                     *"
echo -e "*     ${GREEN}Thank you for participating!${CYAN}    *"
echo -e "*                                     *"
echo -e "***************************************${RESET}"

# Update package list
sudo apt-get update

# Install required packages
sudo apt-get install -y ca-certificates curl

# Create directory for Docker's GPG key
sudo install -m 0755 -d /etc/apt/keyrings

# Download and add Docker's official GPG key
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository to Apt sources
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list again
sudo apt-get update

# Install Docker packages
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start Docker service
sudo service docker start

# Verify installation

# Install dependencies
echo "Installing git..."
sudo apt install git -y

echo "Installing docker.io..."
sudo apt install docker.io -y

# Start and enable Docker service
echo "Starting and enabling Docker..."
sudo systemctl start docker
sudo systemctl enable docker

# Check Docker status
echo "Checking Docker status..."
sudo systemctl status docker

# Clone DA-Client repository
echo "Cloning DA-Client repository..."
git clone https://github.com/0glabs/0g-da-client.git

# Go to DA-Client directory
cd 0g-da-client

# Build Docker image
echo "Building Docker image..."
docker build -t 0g-da-client -f combined.Dockerfile .

# Create envfile.env
echo "Creating envfile.env..."
cat <<EOF > envfile.env
COMBINED_SERVER_CHAIN_RPC=https://evmrpc-testnet.0g.ai
COMBINED_SERVER_PRIVATE_KEY=YOUR_PRIVATE_KEY
ENTRANCE_CONTRACT_ADDR=0x857C0A28A8634614BB2C96039Cf4a20AFF709Aa9

COMBINED_SERVER_RECEIPT_POLLING_ROUNDS=180
COMBINED_SERVER_RECEIPT_POLLING_INTERVAL=1s
COMBINED_SERVER_TX_GAS_LIMIT=2000000
COMBINED_SERVER_USE_MEMORY_DB=true
COMBINED_SERVER_KV_DB_PATH=/runtime/
COMBINED_SERVER_TimeToExpire=2592000
DISPERSER_SERVER_GRPC_PORT=51001
BATCHER_DASIGNERS_CONTRACT_ADDRESS=0x0000000000000000000000000000000000001000
BATCHER_FINALIZER_INTERVAL=20s
BATCHER_CONFIRMER_NUM=3
BATCHER_MAX_NUM_RETRIES_PER_BLOB=3
BATCHER_FINALIZED_BLOCK_COUNT=50
BATCHER_BATCH_SIZE_LIMIT=500
BATCHER_ENCODING_INTERVAL=3s
BATCHER_ENCODING_REQUEST_QUEUE_SIZE=1
BATCHER_PULL_INTERVAL=10s
BATCHER_SIGNING_INTERVAL=3s
BATCHER_SIGNED_PULL_INTERVAL=20s
BATCHER_EXPIRATION_POLL_INTERVAL=3600
BATCHER_ENCODER_ADDRESS=DA_ENCODER_SERVER
BATCHER_ENCODING_TIMEOUT=300s
BATCHER_SIGNING_TIMEOUT=60s
BATCHER_CHAIN_READ_TIMEOUT=12s
BATCHER_CHAIN_WRITE_TIMEOUT=13s
EOF

echo "Setup completed successfully!"

# Final message
echo "***************************************"
echo "*                                     *"
echo "*     Thank you for participating!    *"
echo "*                                     *"
echo "***************************************"
