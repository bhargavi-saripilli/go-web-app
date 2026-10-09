FROM golang:1.27 AS build
WORKDIR /app
COPY go.mod go.sum* ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -o main .

FROM gcr.io/distroless/base
WORKDIR /app
COPY --from=build /app/main .
COPY --from=build /app/static ./static
EXPOSE 8080
CMD ["./main"]
