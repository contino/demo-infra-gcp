# demo-infra-gcp
Infra for demo application using GCP

Create a bucket for terraform state

Create a service account for terraform

Create a service account for container registry

Create secret using container registry service account

kubectl create secret docker-registry gcr-json-key --docker-server=eu.gcr.io --docker-username=_json_key --docker-password="$(cat /Users/japrakash/Downloads/kubernetes-cp-9be3d10470aa.json)"          