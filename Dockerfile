# runtime
FROM golang:latest
RUN apt update
RUN apt install -y libgtk-3-dev libwebkit2gtk-4.0-dev libgnutls30 xz-utils
ADD https://github.com/upx/upx/releases/download/v4.0.1/upx-4.0.1-amd64_linux.tar.xz /usr/local
RUN xz -d -c /usr/local/upx-4.0.1-amd64_linux.tar.xz | tar -xOf - upx-4.0.1-amd64_linux/upx > /bin/upx && \
    chmod a+x /bin/upx
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash && \
	apt install -y nodejs 
RUN npm install -g yarn
RUN go install github.com/wailsapp/wails/v2/cmd/wails@latest