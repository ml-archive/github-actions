FROM nodesvapor/vapor-ci:swift-5.0

RUN apt-get update && apt-get install -y \
    libsqlite3-dev ruby-dev && \
    rm -r /var/lib/apt/lists/*

ENV SOURCEKITTEN_REVISION="0.24.0"
ENV JAZZY_VERSION="0.10.0"
ENV GITHUB_REPOSITORY="nodes-vapor/submissions"
ENV TARGET="Submissions"

# Install SourceKitten
RUN git clone --branch $SOURCEKITTEN_REVISION https://github.com/jpsim/SourceKitten.git && \
    cd SourceKitten && \
    swift build --configuration release --static-swift-stdlib && \
    mv `swift build --configuration release --static-swift-stdlib --show-bin-path`/sourcekitten /usr/bin && \
    cd .. && \
    rm -rf SourceKitten && \
    gem install bundler && \
    gem install jazzy --version "$JAZZY_VERSION"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
