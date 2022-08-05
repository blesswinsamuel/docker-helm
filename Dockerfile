# FROM golang:1.19-alpine AS webhookd-builder

# RUN go install github.com/ncarlier/webhookd@v1.15.0
# RUN which webhookd

FROM alpine

RUN apk add --no-cache curl ca-certificates bash git
RUN apk add --no-cache helm kubectl webhook --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing

RUN helm plugin install https://github.com/databus23/helm-diff && rm -rf /tmp/helm-*
RUN helm plugin install https://github.com/quintush/helm-unittest && rm -rf /tmp/helm-*
RUN helm plugin install https://github.com/chartmuseum/helm-push && rm -rf /tmp/helm-*

# COPY --from=webhookd-builder /go/bin/webhookd /bin/webhookd
