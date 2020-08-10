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
  # creat config.txt
  echo "creating config.txt"
  if [ -z "$NOTIFY_ACCOUNT" ]; then
    cat >config.txt <<EOF
login $QQ_ACCOUNT $QQ_PASSWORD

EOF
  else
    cat >config.txt <<EOF
login $QQ_ACCOUNT $QQ_PASSWORD
say $NOTIFY_ACCOUNT cqhttp_mirai_published!

EOF
  fi
  # create plugins/setting.yml
  echo "creating plugins/setting.yml"
  cat >plugins/setting.yml <<EOF
"$QQ_ACCOUNT":
  ws_reverse:
    - enable: true
      postMessageFormat: string
      reverseHost: $REVERSE_HOST
      reversePort: $REVERSE_PORT
      reversePath: /ws
      reconnectInterval: 3000
EOF
fi

echo "start cqhttp-mirai"
cat config.txt | java -jar cqhttp-mirai.jar
