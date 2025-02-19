#!/bin/bash
rm -rf pop && pkill -f pop
curl -L https://dl.pipecdn.app/v0.2.8/pop -o pop
chmod +x pop
/pop --refresh
./pop
