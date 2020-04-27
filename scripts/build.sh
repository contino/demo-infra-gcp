#!/bin/sh

set -ex

export GOOGLE_APPLICATION_CREDENTIALS="${GCP_CREDS}"

cd terraform
terraform init
terraform plan
terraform apply -auto-approve


