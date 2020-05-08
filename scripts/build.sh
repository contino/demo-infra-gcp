#!/bin/sh
set -euo pipefail

. ./functions.sh

assert_variables_set "$GCP_CREDS" "$CLUSTER_NAME" "$CLUSTER_REGION" "$GCP_PROJECT"

authenticate_with_gcloud "$GCP_CREDS"

run_terraform "${GCP_CREDS}" "${GCP_PROJECT}"

finish
