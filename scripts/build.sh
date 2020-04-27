#!/bin/sh

set -ex

# project name same as file name for onboarding
readonly PROJNAME="kubernetes-cp"

cat <<EOF > creds.json
$GCP_CREDS
EOF

export GOOGLE_APPLICATION_CREDENTIALS="creds.json"

cd terraform
terraform init
terraform plan
terraform apply -auto-approve
rm creds.json


