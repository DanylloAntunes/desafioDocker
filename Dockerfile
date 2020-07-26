FROM golang:alpine as builder

WORKDIR /var/www/

RUN go get -d -v ./...
RUN go install -v ./...

COPY . /var/www/
WORKDIR /var/www/app

RUN go build -a -installsuffix cgo -o main .

FROM alpine:3.5
WORKDIR /root/
COPY --from=builder /var/www/app/main .

CMD [ "./main" ]