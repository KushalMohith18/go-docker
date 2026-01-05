# syntax=docker/dockerfile:1.4

FROM golang:1.21-alpine AS builder

WORKDIR /src

# Copy module file first (cache key)
COPY go.mod ./

# Copy application source
COPY app ./app

# Build (LAYER CACHE, not cache mount)
RUN go build -o app ./app

# ----------------------------

FROM alpine:latest

WORKDIR /app
COPY --from=builder /src/app .

EXPOSE 8080
CMD ["./app"]
