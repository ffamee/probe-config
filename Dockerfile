FROM telegraf:1.37

COPY ./telegraf/librespeed-cli/librespeed-cli-linux-amd64 /usr/local/bin/librespeed-cli

RUN chmod +x /usr/local/bin/librespeed-cli

RUN apt update && \
	apt install -y iproute2 jq && \
	rm -rf /var/lib/apt/lists/*
