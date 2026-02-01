FROM telegraf:1.37

RUN apt update && \
	apt install -y iproute2 jq && \
	rm -rf /var/lib/apt/lists/*
