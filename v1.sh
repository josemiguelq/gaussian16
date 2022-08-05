#!/bin/sh

OUTPUT_PATH="triazol-Cu-opt.log"
INPUT_PATH="coordinates_input.xyz"

start_time=$SECONDS
sleep 5
g16 < $1 > OUTPUT_PATH
elapsed=$(( SECONDS - start_time ))

# Parse to last geometry
python parse.py

# Notify
curl -X POST https://api.telegram.org/$TELEGRAM_TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="Finalizado+Opt+Tempo gasto: $elapsed seg"

# Using the first gaussian output
g16 < $INPUT_PATH > "$2.log"
g16 < $INPUT_PATH > "$3.log"


curl -X POST https://api.telegram.org/$TELEGRAM_TOKEN/sendMessage -d chat_id=$CHAT_ID -d text=Finalizado