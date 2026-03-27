FROM ubuntu:22.04

# Non-interactive mode taaki build na ruke
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openssh-server curl wget git sudo iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Tailscale install
RUN curl -fsSL https://tailscale.com/install.sh | sh

# SSH Setup
RUN mkdir /var/run/sshd && echo 'root:gg-gamer-786' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

COPY start.sh /start.sh
RUN chmod +x /start.sh

# Railway ke liye environment variables
ENV SSH_PORT=22
EXPOSE 22

CMD ["bash", "/start.sh"]
