#!/bin/sh
set -euo pipefail

. ./scripts/functions.sh

assert_variables_set $GCP_CREDS $CLUSTER_NAME $CLUSTER_REGION $GCP_PROJECT

authenticate_with_gcloud "$GCP_CREDS"

run_kubernetes_yaml "${GCP_CREDS}" "${CLUSTER_NAME}" "${GCP_PROJECT}"

finish
