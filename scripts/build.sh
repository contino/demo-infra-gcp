#!/bin/sh

set -ex

cd terraform
terraform init
terraform plan
terraform apply -auto-approve