FROM alpine:latest

# install tools
RUN apk add -u git wget bash



# lucky requirements

# overmind
RUN apk add -u tmux
RUN wget https://github.com/DarthSim/overmind/releases/download/v2.0.2/overmind-v2.0.2-linux-amd64.gz && \
    gunzip *.gz && mv overmind* /usr/local/bin/overmind && \
    chmod +x /usr/local/bin/overmind

# node
RUN apk add -u nodejs yarn

# crystal
RUN apk add -u crystal shards libc-dev

# postgres
RUN apk add -u postgresql-dev


# build lucky
RUN apk add -u zlib-dev make yaml-dev
RUN git clone https://github.com/luckyframework/lucky_cli.git && \
    cd lucky* && \
    shards install && \
    crystal build src/lucky.cr && \
    mv lucky /usr/local/bin/lucky && \
    lucky -v

# WORKDIR /src
# COPY . .
# RUN crystal build --release test.cr -o /test
# ENTRYPOINT ["/test"]

