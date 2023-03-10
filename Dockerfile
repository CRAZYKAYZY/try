## Build
FROM golang:1.19.4-buster AS build

WORKDIR /app

#RUN go install github.com/cosmtrek/air@latest

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

COPY .  .

RUN go mod tidy

RUN go build -o /try

## Deploy
FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /try /try

EXPOSE 8080

ENTRYPOINT ["/try"]