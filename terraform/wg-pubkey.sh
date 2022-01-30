#!/usr/bin/env bash

eval "$(jq -r '@sh "PRIVATE_KEY=\(.private_key)"')"
PUBLIC_KEY=$(echo ${PRIVATE_KEY} | wg pubkey)
jq -n --arg public_key "${PUBLIC_KEY}" '{"public_key":$public_key}'
