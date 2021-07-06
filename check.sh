#!/bin/bash
if [ -z "$QQ_ACCOUNT" ]; then
  echo "QQ_ACCOUNT is null, just start cqhttp-mirai"
  echo "QQ_ACCOUNT 为空，直接启动cqhttp-mirai"
else
  echo "start create config files with env vars"
  if [ -z "$QQ_PASSWORD" ]; then
    echo "QQ_PASSWORD can not be null"
    echo "QQ_PASSWORD 不能为空"
    exit 1
  fi
  if [ -z "$REVERSE_HOST" ]; then
    echo "REVERSE_HOST can not be null"
    echo "REVERSE_HOST 不能为空"
    exit 1
  fi
  if [ -z "$REVERSE_PORT" ]; then
    REVERSE_PORT=8000
  fi
  # create device.json
  echo "creating device.json"
  if [ ! -f "device.json" ]; then
    cp device.json.example device.json
  fi
  # create /workdir/config/OneBot/settings.yml
  echo "creating  /workdir/config/OneBot/settings.yml"
  mkdir -p /workdir/config/OneBot
  cat > /workdir/config/OneBot/settings.yml <<EOF
bots:
  $QQ_ACCOUNT:
    ws_reverse:
      - enable: true
        postMessageFormat: string
        reverseHost: $REVERSE_HOST
        reversePort: $REVERSE_PORT
        accessToken: ''
        reversePath: '/ws'
        useUniversal: true
        useTLS: false
        reconnectInterval: 3000
EOF
fi

echo "start cqhttp-mirai"
