#!/bin/sh

set -ex

cd terraform \
&& terraform init -backend=false \
&& terraform validate
