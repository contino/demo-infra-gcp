FROM hashicorp/terraform:0.13.6

RUN apk add --update python3 \
    && apk add curl

RUN curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-323.0.0-linux-x86_64.tar.gz > /tmp/google-cloud-sdk.tar.gz \
    && mkdir -p /usr/local/gcloud \
    && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
    && /usr/local/gcloud/google-cloud-sdk/install.sh --quiet \
    && rm /tmp/google-cloud-sdk.tar.gz

ENV KUBE_LATEST_VERSION="v1.17.14"

RUN apk add --no-cache ca-certificates bash git \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin
