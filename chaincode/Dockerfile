FROM golang:1.14.6-alpine AS build

COPY ./example_cc /go/src/github.com/examplecc
WORKDIR /go/src/github.com/examplecc
ENV GOPROXY=https://goproxy.cn,direct

# Build application
RUN go build -o chaincode -v .

# Production ready image
# Pass the binary to the prod image
FROM alpine:3.11 as prod

COPY --from=build /go/src/github.com/examplecc/chaincode /app/chaincode


EXPOSE 9999

WORKDIR /app
CMD ./chaincode
