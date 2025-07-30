FROM golang:1.24.4-alpine AS builder
RUN go install tailscale.com/cmd/derper@main

FROM alpine
WORKDIR /app

ENV DERP_DOMAIN=your-hostname.com
ENV DERP_VERIFY_CLIENTS=false

COPY --from=builder /go/bin/derper .

CMD /app/derper -hostname $DERP_DOMAIN -certmode manual -certdir /cert -stun -verify-clients=$DERP_VERIFY_CLIENTS
