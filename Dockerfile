FROM golang:1.22.0-alpine AS builder

ENV GO111MODULE=on

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /go-app

FROM alpine:3.18

COPY --from=builder /go-app /go-app

EXPOSE 8080

ENTRYPOINT ["/go-app"]
