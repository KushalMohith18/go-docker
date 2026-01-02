# syntax=docker/dockerfile:1.4

FROM golang:1.21-alpine as builder

WORKDIR /src

# Use buildkit cache for module cache
RUN --mount=type=cache,target=/root/.cache/go-build \
    --mount=type=cache,target=/go/pkg/mod \
    go mod download

COPY . .

RUN --mount=type=cache,target=/root/.cache/go-build \
    --mount=type=cache,target=/go/pkg/mod \
    go build -o app ./app

FROM alpine:latest
WORKDIR /app
COPY --from=builder /src/app .

CMD ["./app"]
