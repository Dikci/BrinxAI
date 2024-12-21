sudo apt-get install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker
sudo apt-get install ufw
sudo ufw allow 5011/tcp
sudo ufw --force enable
git clone https://github.com/admier1/BrinxAI-Worker-Nodes
cd BrinxAI-Worker-Nodes
curl -O https://raw.githubusercontent.com/Dikci/BrinxAI/refs/heads/main/brinx.sh && chmod +x brinx.sh && ./brinx.sh
