# syntax=docker/dockerfile:1.4

FROM golang:1.21-alpine AS builder
WORKDIR /src

COPY go.mod ./
COPY app ./app

# CI-correct caching
RUN --mount=type=cache,target=/root/.cache/go-build \
    go build -o app ./app

FROM alpine:latest
WORKDIR /app
COPY --from=builder /src/app .

EXPOSE 8080
CMD ["./app"]
