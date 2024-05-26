FROM debian:bookworm-slim
MAINTAINER "Hiroki Takeyama"

# timezone
RUN apt update && apt install -y tzdata; \
    apt clean;

# SSH client & tools
RUN apt install -y openssh-client iproute2 iputils-ping vim-nox nano rsync sudo less tmux;

# Create user
RUN useradd -m user -s /bin/bash -G sudo

# sshd
RUN mkdir /var/run/sshd; \
    apt install -y openssh-server; \
    sed -i 's/^#\(PermitRootLogin\) .*/\1 yes/' /etc/ssh/sshd_config; \
    sed -i 's/^\(UsePAM yes\)/# \1/' /etc/ssh/sshd_config; \
    apt clean;

# entrypoint
RUN { \
    echo '#!/bin/bash -eu'; \
    echo 'ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime'; \
    echo 'echo "root:${ROOT_PASSWORD}" | chpasswd'; \
    echo 'echo "user:${USER_PASSWORD}" | chpasswd'; \
    echo 'echo "export PS1=\"internal-machine($(hostname -i))# \"" > /root/.bashrc'; \
    echo 'echo "export PS1=\"internal-machine($(hostname -i))$ \"" > /home/user/.bashrc'; \
    echo 'echo "VisualHostKey yes" > /etc/ssh/ssh_config.d/visualhostkey.conf'; \
    echo 'echo "IP address(es) of "internal-machine": $(hostname -i)"'; \
    echo 'exec "$@"'; \
    } > /usr/local/bin/entry_point.sh; \
    chmod +x /usr/local/bin/entry_point.sh;

COPY keys/* /etc/ssh/

ENV TZ Europe/Luxembourg

ENV ROOT_PASSWORD root
ENV USER_PASSWORD user

EXPOSE 22

ENTRYPOINT ["entry_point.sh"]
CMD    ["/usr/sbin/sshd", "-D", "-e"]
