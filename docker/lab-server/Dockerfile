FROM debian:bookworm-slim
MAINTAINER "Hiroki Takeyama"

# timezone
RUN apt update && apt install -y tzdata; \
    apt clean;

# SSH client & tools
RUN apt install -y openssh-client iproute2 iputils-ping vim-nox nano rsync sudo less inetutils-telnetd endlessh tmux x11-utils x11-apps;

# Create user
RUN useradd -m user -s /bin/bash -G sudo

# Activate telnetd
RUN sed -i 's/^#<off># \(telnet\)/\1/' /etc/inetd.conf; \
    chmod u+s /usr/bin/login; \
    echo "ALL: ALL" > /etc/hosts.allow;

# sshd
RUN mkdir /var/run/sshd; \
    apt install -y openssh-server; \
    sed -i 's/^#\(PermitRootLogin\) .*/\1 yes/' /etc/ssh/sshd_config; \
    sed -i 's/^\(UsePAM yes\)/# \1/' /etc/ssh/sshd_config; \
    apt clean;

# entrypoint
RUN { \
    echo '#!/bin/bash -eu'; \
    echo "sed -i 's/files dns/files/' /etc/nsswitch.conf"; \
    echo 'ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime'; \
    echo 'echo "root:${ROOT_PASSWORD}" | chpasswd'; \
    echo 'echo "user:${USER_PASSWORD}" | chpasswd'; \
    echo 'echo "export PS1=\"lab-server($(hostname -i))# \"" > /root/.bashrc'; \
    echo 'echo "export PS1=\"lab-server($(hostname -i))$ \"" > /home/user/.bashrc'; \
    echo 'echo "VisualHostKey yes" > /etc/ssh/ssh_config.d/visualhostkey.conf'; \
    echo 'echo "IP address(es) of lab-server: $(hostname -i)"'; \
    echo 'exec "$@"'; \
    } > /usr/local/bin/entry_point.sh; \
    chmod +x /usr/local/bin/entry_point.sh;

COPY keys/* /etc/ssh/

ENV TZ Europe/Luxembourg

ENV ROOT_PASSWORD root
ENV USER_PASSWORD user

EXPOSE 22

ENTRYPOINT ["entry_point.sh"]
CMD    /usr/bin/endlessh -d 1000 & /usr/sbin/inetutils-inetd ; /usr/sbin/sshd -D -e
