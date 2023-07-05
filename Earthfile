# it's mean to be used for ./.github/workflows/uses-earthly.yml

VERSION 0.7

build:
  FROM earthly/dind:alpine
  ARG ENV_VAR_A

  WORKDIR /opt/earthly

  COPY ./docker-compose.for-earthly.yml .

  WITH DOCKER --pull busybox
    RUN --no-cache --secret ENV_VAR_SECRET \
      docker-compose -f docker-compose.for-earthly.yml \
      run --rm busybox printenv ENV_VAR_A ENV_VAR_SECRET
  END
