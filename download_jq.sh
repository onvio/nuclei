#!/bin/bash
set -x

wget --quiet https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod u+x jq-linux64
mv jq-linux64 /usr/bin/jq
