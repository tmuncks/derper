### builder
FROM golang:alpine AS builder

# https://tailscale.com/kb/1118/custom-derp-servers/
RUN go install tailscale.com/cmd/derper@main

### runtime
FROM alpine:latest
WORKDIR /app

COPY --from=builder /go/bin/derper .

ENV DERP_DOMAIN derp.example.com

CMD /app/derper --hostname $DERP_DOMAIN
