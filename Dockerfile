FROM golang:alpine as builder

WORKDIR /var/www/

RUN go get -d -v ./...
RUN go install -v ./...

COPY . /var/www/
WORKDIR /var/www/app

RUN go build -ldflags="-s -w" -o main .

FROM scratch
#WORKDIR /root/
COPY --from=builder /var/www/app/main .

CMD [ "./main" ]