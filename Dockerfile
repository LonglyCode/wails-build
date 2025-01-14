# syntax=docker/dockerfile:1.4
FROM --platform=$TARGETPLATFORM golang:latest
ARG TARGETPLATFORM
RUN apt update
RUN apt install -y libgtk-3-dev libwebkit2gtk-4.0-dev libgnutls30 xz-utils

# Install UPX based on architecture
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
        curl -L -o upx.tar.xz https://github.com/upx/upx/releases/download/v4.0.1/upx-4.0.1-amd64_linux.tar.xz && \
        tar -xf upx.tar.xz && \
        mv upx-4.0.1-amd64_linux/upx /bin/upx && \
        chmod a+x /bin/upx && \
        rm -rf upx-4.0.1-amd64_linux upx.tar.xz; \
    elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
        curl -L -o upx.tar.xz https://github.com/upx/upx/releases/download/v4.0.1/upx-4.0.1-arm64_linux.tar.xz && \
        tar -xf upx.tar.xz && \
        mv upx-4.0.1-arm64_linux/upx /bin/upx && \
        chmod a+x /bin/upx && \
        rm -rf upx-4.0.1-arm64_linux upx.tar.xz; \
    fi

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs && \
    npm install -g yarn

RUN go install github.com/wailsapp/wails/v2/cmd/wails@latest