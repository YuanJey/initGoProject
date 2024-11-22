FROM golang:latest AS builder
ENV CGO_ENABLED 0
ENV GOPROXY https://goproxy.cn,direct
WORKDIR /app
COPY . .
RUN go mod tidy
WORKDIR /app/cmd/main
RUN go build -o main .


FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/cmd/main/main .
COPY --from=builder /app/config/config.yaml .
EXPOSE 8000
CMD ["./main"]