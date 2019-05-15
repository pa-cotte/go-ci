FROM golang:1.12-alpine

# Get library requirements.
RUN apk update && apk add make git build-base curl autoconf automake libtool docker python bash \
    && curl -sL https://get.docker.com/builds/Linux/x86_64/docker-1.8.1 > /usr/bin/docker \
    && chmod +x /usr/bin/docker

# install gcloud sdk
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/root/google-cloud-sdk/bin

# Get C++ protobuf library.
RUN git clone https://github.com/google/protobuf -b v3.6.1.2 --depth 1
# Install C++ protobuf library.
RUN cd protobuf && ./autogen.sh && ./configure && make && make install && cd .. && rm -rf protobuf
# Install golang protobuf generator.
RUN go get -u github.com/golang/protobuf/protoc-gen-go
RUN cd $GOPATH/src/github.com/golang/protobuf/protoc-gen-go && git checkout v1.2.0 && go install
