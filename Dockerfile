# syntax=docker/dockerfile:1.4

FROM golang:1.21-alpine AS builder

WORKDIR /src

# Copy go.mod first (still good practice)
COPY go.mod ./

# Copy source
COPY app ./app

# Build with cache
RUN --mount=type=cache,target=/root/.cache/go-build \
    go build -o app ./app

# ----------------------------

FROM alpine:latest
WORKDIR /app
COPY --from=builder /src/app .

EXPOSE 8080
CMD ["./app"]
