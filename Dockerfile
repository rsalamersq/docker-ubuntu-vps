ARG         UBUNTU_VERSION=${UBUNTU_VERSION:-18.10}
FROM        ubuntu:${UBUNTU_VERSION}

LABEL maintainer="Thomas Grimonet"
LABEL com.example.version="1.1"
LABEL vendor1="Inetsix"
LABEL com.example.release-date="2019-05-10"
LABEL com.example.version.is-production="True"

# VPS Setup
ENV VPS_USER="netscreen"
ENV VPS_GROUP $VPS_USER
ENV VPS_PASSWORD="netscreen"
ENV VPS_ENABLE_SUDO true

# System ENV
ENV TIMEZONE Etc/UTC
ENV DEBIAN_FRONTEND noninteractive
ENV PATH "$PATH:/opt/bin:/usr/local/bin"
ENV TERM xterm
ENV PERL_MM_USE_DEFAULT true

USER root

RUN apt-get update && \
    apt-get install -y \
                    software-properties-common \
                    locales \
                    openssh-server \
                    curl \
                    git \
                    vim \
                    ruby \
                    make \
                    unzip \
                    screen \
                    nodejs \
                    npm \
                    whois \
                    dnsutils \
                    traceroute \
                    telnet \
                    mtr \
                    libxml2 \
                    libxml2-dev \
                    libz-dev \
                    libexpat-dev \
                    python-pip \
                    python-requests \
                    tzdata \
                    sudo \
                    iputils-ping \
                    net-tools \
                    iproute2 \
                    zsh \
                    && \
    mkdir -p /var/run/sshd && \
    mkdir -p /usr/local/bin && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/vps && \
    sed -i 's:session\s*required\s*pam_loginuid.so:session optional pam_loginuid.so:g' /etc/pam.d/sshd && \
    ([ -f /etc/ssh/ssh_host_rsa_key ] || ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key)  && \
    mkdir -p /root/.ssh/ -m 0700 && \
    echo '\nHost github.com\n  StrictHostKeyChecking no\n  UserKnownHostsFile=/dev/null' >> /root/.ssh/config && \
    echo '\nHost gitlab.com\n  StrictHostKeyChecking no\n  UserKnownHostsFile=/dev/null' >> /root/.ssh/config 

# Locale specific
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN locale-gen $LANGUAGE && \
    dpkg-reconfigure locales && \
    echo "$TIMEZONE" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

ADD bin /opt/bin
ADD start /start
ADD env.sh /etc/profile.d/
ADD motd /etc/motd
ADD .vimrc /root/.vimrc
ADD .vimrc /etc/skel/.vimrc

EXPOSE 22

ENTRYPOINT ["/start"]

