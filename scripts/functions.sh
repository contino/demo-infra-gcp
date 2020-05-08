#!/bin/sh

function assert_variables_set() {
  local error=0
  local varname
  for varname in "$@"; do
    if [ -z "${!varname-}" ]; then
      echo "${varname} must be set" >&2
      error=1
    fi
  done
  if [ ${error} = 1 ]; then
    exit 1
  fi
}

function check_params() {
  params="$1"
  params_split={$params}
  actual_param_count=${#params_split[@]}
  shift
  expected_param_count="$#"
  if [[ $actual_param_count -ne $expected_param_count ]]; then
    echo "ERROR: ${FUNCNAME[1]} requires $expected_param_count parameter(s) : $@"
    return 1
  fi
}

function authenticate_with_gcloud() {
  local credentials_json=$1

  echo "-> Authenticating with GCloud"
  echo "${credentials_json}" | gcloud auth activate-service-account --key-file -
  gcp_project_name=$(echo "$credentials_json" | jq -r '.project_id')
  gcloud config set project "${gcp_project_name}"
}

function kubectl_login() {
  check_params "$*" "cluster_name" "project"
  local cluster_name=$1
  local project=$2

  gcloud container clusters get-credentials "$cluster_name" --project "$project"
}

function run_terraform() {
  check_params "$*" "gcp_creds" "project"
  local gcp_creds=$1
  local project=$2

  echo "-> Running terraform"
  pushd terraform/
  export TF_VAR_project_id="${project}"
  terraform init
  terraform apply -auto-approve
  popd
}

function apply_kubernetes_resources() {
  check_params "$*" "gcp_creds"
  local gcp_creds=$1
  export BACKUP_BUCKET=hydrogen-${gcp_creds}-backup

  cat kubernetes/* | envsubst | kubectl apply -f -
}

function finish() {
  echo "-> Revoking GCloud auth"
  gcloud auth revoke
}

function run_kubernetes_yaml() {
  check_params "$*" "gcp_creds" "cluster" "project"

  local gcp_creds=$1
  local cluster=$2
  local project=$3

  echo -e "\\n---Creating resources for ${cluster}---"

  kubectl_login "${cluster}" "${project}"
  apply_kubernetes_resources "${gcp_creds}"
}
