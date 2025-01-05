FROM ghcr.io/supportpal/github-gh-cli:latest AS github-cli

# Container image that runs your code
FROM alpine:3.20

RUN apk add --no-cache bash curl jq git
COPY --from=github-cli /usr/bin/gh /usr/bin/gh

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
