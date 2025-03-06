FROM golang:1.24.1
WORKDIR /app
COPY src/main.go .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main main.go

FROM scratch
COPY --from=0 /app/main /main
EXPOSE 8080
CMD ["/main"]
