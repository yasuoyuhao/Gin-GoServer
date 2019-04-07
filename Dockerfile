FROM golang:1.12.1-stretch

LABEL maintainer="yasuoyuhao@gmail.com"

# Download and install the latest release of dep
ADD https://github.com/golang/dep/releases/download/v0.5.1/dep-linux-amd64 /usr/bin/dep
RUN chmod +x /usr/bin/dep

# Copy the code from the host and compile it
WORKDIR $GOPATH/src/Gin-GoServer
COPY Gopkg.toml Gopkg.lock ./
RUN dep ensure --vendor-only
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix nocgo -o ./Gin-GoServer .
EXPOSE 8888
# FROM scratch
# COPY --from=builder /Gin-GoServer ./
ENTRYPOINT ["./Gin-GoServer"]