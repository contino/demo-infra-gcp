#!/bin/sh

set -ex

cd terraform

cat <<EOF > creds.json
$GCP_CREDS
EOF

export GOOGLE_APPLICATION_CREDENTIALS="creds.json"

cat backend.tf

terraform init
terraform plan -out "tf.plan"
terraform apply -auto-approve "tf.plan"
rm "tf.plan"
rm creds.json
cd ../