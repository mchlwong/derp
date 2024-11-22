FROM golang:1.23.1-alpine AS builder
RUN go install tailscale.com/cmd/derper@main

FROM alpine
WORKDIR /app

ENV DERP_DOMAIN your-hostname.com
ENV DERP_VERIFY_CLIENTS false

COPY --from=builder /go/bin/derper .

HEALTHCHECK --interval=3m --timeout=30s --start-period=10s --retries=3 CMD wget --no-verbose --tries=1 --spider https://$DERP_DOMAIN:10443

CMD /app/derper -hostname $DERP_DOMAIN -certmode manual -certdir /cert -stun -verify-clients=$DERP_VERIFY_CLIENTS
