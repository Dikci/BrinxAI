#!/bin/bash
git clone https://github.com/Jaammerr/The-Dawn-Bot.git
cd The-Dawn-Bot
apt install python3.10-venv -y
python3 -m venv myenv
pip install -r requirements.txt
cd /root/The-Dawn-Bot/config/
sed -i 's/threads: 100/threads: 1/' settings.yaml
sed -i 's/use_proxy_for_imap: false/use_proxy_for_imap: true/' settings.yaml
sed -i 's/two_captcha_api_key: ""/two_captcha_api_key: "ce920aea16dae4a647243305b6cea274"/' settings.yaml
