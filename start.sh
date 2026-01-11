#!/bin/sh

if [ -z "$TELEGRAM_API_ID" ]; then
  echo \$TELEGRAM_API_ID is unset
  exit 1
fi

if [ -z "$TELEGRAM_API_HASH" ]; then
  echo \$TELEGRAM_API_HASH is unset
  exit 1
fi

/srv/telegram-bot-api --local
