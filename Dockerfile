FROM golang:alpine AS builder
RUN go install tailscale.com/cmd/derper@main

FROM alpine
WORKDIR /app

ENV DERP_DOMAIN your-hostname.com

COPY --from=builder /go/bin/derper .

CMD /app/derper -hostname $DERP_DOMAIN -certmode manual -certdir /cert -stun