FROM swift:4.2
MAINTAINER Rasmus Ebbesen (re@nodes.dk)
RUN apt-get update && apt-get install -y clang libblocksruntime0 libcurl4-openssl-dev
RUN apt-get install -y ruby-full make gcc libsqlite3-dev
RUN gem install jazzy
RUN git clone https://github.com/jpsim/SourceKitten.git ./SourceKitten
WORKDIR SourceKitten/
RUN swift build -c release --static-swift-stdlib
RUN mv .build/x86_64-unknown-linux/release/sourcekitten /usr/local/bin/
WORKDIR /
RUN rm -rf SourceKitten
RUN git clone https://github.com/nodes-vapor/bootstrap.git ./project
WORKDIR project/
RUN ls -lisa
RUN swift package update
RUN swift build
RUN sourcekitten doc --spm-module Bootstrap > Bootstrap.json
RUN jazzy \
  --clean \
  --sourcekitten-sourcefile Bootstrap.json \
  --module Bootstrap
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
