# runtime
FROM golang:latest
RUN apt update
RUN apt install -y libgtk-3-dev libwebkit2gtk-4.0-dev libgnutls30
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash && \
	apt install -y nodejs 
RUN npm install -g yarn
RUN go install github.com/wailsapp/wails/v2/cmd/wails@latest