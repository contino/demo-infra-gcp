#!/bin/sh
set -euo pipefail

cd terraform
terraform init -backend=false
terraform validate
