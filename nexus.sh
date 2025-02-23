tmux kill-session -t nexus
cd && rm -rf .nexus/
sudo swapoff /swapfile && sudo rm /swapfile && sudo sed -i '/\/swapfile none swap sw 0 0/d' /etc/fstab
