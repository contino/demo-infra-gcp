#!/bin/sh

set -ex

# project name same as file name for onboarding
readonly PROJNAME="kubernetes-cp"

export GOOGLE_APPLICATION_CREDENTIALS=$GCP_CREDS

cd terraform
terraform init
terraform plan
terraform apply -auto-approve


