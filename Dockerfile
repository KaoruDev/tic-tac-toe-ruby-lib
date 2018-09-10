FROM ruby:2.5.1-alpine3.7 as bundler

COPY . ./

RUN apk add --update alpine-sdk sqlite sqlite-dev sqlite-libs \
  && bundle install

FROM ruby:2.5.1-alpine3.7

RUN apk add --update sqlite sqlite-dev sqlite-libs

COPY --from=bundler /usr/local/bundle /usr/local/bundle
COPY . ./hummingbird
WORKDIR /hummingbird

ENTRYPOINT ["./bin/example"]
