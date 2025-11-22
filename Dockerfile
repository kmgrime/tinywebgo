FROM golang:1.25.4-alpine AS builder

WORKDIR /app

COPY . .

RUN go build -o main

FROM alpine:latest as runner

ENV GO_ENV=prod

WORKDIR /app

COPY --from=builder /app/main .
COPY --from=builder /app/index.html .

EXPOSE 8080

CMD ["./main"]
