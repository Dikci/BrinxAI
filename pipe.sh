#!/bin/bash
rm -rf pop && pkill -f pop
curl -L https://dl.pipecdn.app/v0.2.4/pop -o pop
chmod +x pop
/pop --refresh
yes | ./pop
