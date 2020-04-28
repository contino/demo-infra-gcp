#!/bin/sh

set -ex

cd terraform \
&& terraform init \
&& terraform validate