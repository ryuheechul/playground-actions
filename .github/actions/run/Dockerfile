# Thanks https://github.com/line/kubectl-kustomize/blob/9f5b08e8fc381d7bd717cd11ef74a3c088176ee5/Dockerfile
FROM curlimages/curl:7.81.0 AS downloader

ARG TARGETOS
ARG TARGETARCH
ARG KUBECTL_VERSION=v1.23.3
ARG KUSTOMIZE_VERSION=v4.5.2
ARG YQ_VERSION=v4.19.1

ENV platform_ref=${TARGETOS}_${TARGETARCH}

WORKDIR /downloads

RUN set -ex; \
    curl -fL https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/${TARGETOS}/${TARGETARCH}/kubectl -o kubectl && \
    chmod +x kubectl

RUN set -ex; \
    curl -fL https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_${platform_ref}.tar.gz | tar xz && \
    chmod +x kustomize

RUN set -ex; \
    curl -fL https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_${platform_ref}.tar.gz | tar xz && \
    mv yq_${platform_ref} yq && chmod +x yq

# Runtime
FROM ubuntu AS runtime

COPY --from=downloader /downloads/kubectl /usr/local/bin/kubectl
COPY --from=downloader /downloads/kustomize /usr/local/bin/kustomize
COPY --from=downloader /downloads/yq /usr/local/bin/yq

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

# Test
FROM runtime AS test

RUN set -ex; kubectl && kustomize && yq
