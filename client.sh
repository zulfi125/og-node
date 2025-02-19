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

# Update and install dependencies
echo "Updating system and installing dependencies..."
sudo apt update && sudo apt install -y git docker.io

# Start and enable Docker service
echo "Starting and enabling Docker..."
sudo systemctl start docker
sudo systemctl enable docker

# Verify Docker installation
echo "Checking Docker installation..."
docker --version || { echo "${RED}Docker installation failed!${RESET}"; exit 1; }

# Clone OG Node (0G DA-Client) repository
echo "Cloning DA-Client repository..."
git clone https://github.com/0glabs/0g-da-client.git || { echo "${RED}Failed to clone repository!${RESET}"; exit 1; }

# Navigate to the project directory
cd 0g-da-client || { echo "${RED}Failed to enter directory!${RESET}"; exit 1; }

# Build Docker image
echo "Building Docker image..."
docker build -t 0g-da-client -f combined.Dockerfile . || { echo "${RED}Docker build failed!${RESET}"; exit 1; }

# Create envfile.env
echo "Creating envfile.env..."
cat <<EOF > envfile.env
COMBINED_SERVER_CHAIN_RPC=https://evmrpc-testnet.0g.ai
COMBINED_SERVER_PRIVATE_KEY=YOUR_PRIVATE_KEY_HERE  # Replace with your actual private key!
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

echo "${GREEN}Setup completed successfully!${RESET}"

# Final message
echo -e "${CYAN}***************************************"
echo -e "*                                     *"
echo -e "*     ${GREEN}Thank you for participating!${CYAN}    *"
echo -e "*                                     *"
echo -e "***************************************${RESET}"

# Instructions to run the node
echo "${YELLOW}To start your OG Node, run the following command:${RESET}"
echo "${GREEN}docker run --env-file envfile.env -p 51001:51001 -d 0g-da-client${RESET}"
