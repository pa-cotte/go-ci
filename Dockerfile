FROM golang:1.12-alpine

# Get library requirements.
RUN apk update && apk add make git build-base curl autoconf automake libtool docker python bash \
    && curl -sL https://get.docker.com/builds/Linux/x86_64/docker-1.8.1 > /usr/bin/docker \
    && chmod +x /usr/bin/docker

# install gcloud sdk
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/root/google-cloud-sdk/bin

RUN PROTOC_ZIP=protoc-3.7.1-linux-x86_64.zip \
    && curl -OL https://github.com/google/protobuf/releases/download/v3.7.1/$PROTOC_ZIP \
    && unzip -o $PROTOC_ZIP -d /usr/local bin/protoc \
    && rm -f $PROTOC_ZIP
