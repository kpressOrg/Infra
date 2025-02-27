# docker-context/Dockerfile
FROM ubuntu:22.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server && \
    mkdir /var/run/sshd

RUN echo 'root:password' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

CMD ["/usr/sbin/sshd", "-D"]