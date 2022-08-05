#!/bin/sh

OUTPUT_PATH="triazol-Cu-opt.log"
INPUT_PATH="coordinates_input.xyz"

start_time=$SECONDS
g16 < $1 > OUTPUT_PATH
elapsed=$(( SECONDS - start_time ))

# Parse to last geometry
python parse.py

# Notify and send input file
curl -X POST https://api.telegram.org/$TELEGRAM_TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="Finalizado+Opt+Tempo gasto: $elapsed seg. Arquivo gerado: ->"
curl -F document=@"$INPUT_PATH" https://api.telegram.org/$TELEGRAM_TOKEN/sendDocument?chat_id=$CHAT_ID

# Using the first gaussian output
g16 < $INPUT_PATH > "$2.log"
g16 < $INPUT_PATH > "$3.log"


curl -X POST https://api.telegram.org/$TELEGRAM_TOKEN/sendMessage -d chat_id=$CHAT_ID -d text=Finalizado