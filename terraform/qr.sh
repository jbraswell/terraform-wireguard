#!/usr/bin/env bash


if ! which qrencode > /dev/null || ! which jq > /dev/null; then
    echo '{"code": "Install qrencode and jq to generate wireguard client configuration QR codes."}'
    exit
fi

eval "$(jq -r '@sh "config=\(.config)"')"
code=$(echo "$config" | qrencode -t ansiutf8 -m 2)
jq -n --arg code "$code" '{"code": $code}'
