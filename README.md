# Ubuntu Docker VPS

[![Build Status](https://www.travis-ci.org/titom73/docker-ubuntu-vps.svg?branch=master)](https://www.travis-ci.org/titom73/docker-ubuntu-vps)
![](https://img.shields.io/docker/pulls/inetsix/vps-ubuntu.svg)
[![](https://images.microbadger.com/badges/image/inetsix/vps-ubuntu.svg)](https://microbadger.com/images/inetsix/vps-ubuntu "Get your own image badge on microbadger.com")

Use this Dockerfile / -image to start a VPS instance upon an Ubuntu container

## Features

- Use latest version of Ubuntu
- Provides basic VPS tools
- User defined username and password

## Basic Usage

### Password Definition

```shell
$ docker run -d -P --name vps 
        -e VPS_USER=tom 
        -e VPS_PASSWORD=passowrd 
        inetsix/vps-ubuntu
```

### Retrieve Container IP address 

```shell
$ docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' vps
172.17.0.2

$ ssh 172.17.0.2 -l tom

The authenticity of host '172.17.0.2 (172.17.0.2)' can't be established.
ECDSA key fingerprint is SHA256:Q1U1F8zgX25tgcGWJucMa0IR+hbT1subwFGFmLoKXrk.
Are you sure you want to continue connecting (yes/no)? yes
Failed to add the host to the list of known hosts (/home/tom/.ssh/known_hosts).
tom@172.17.0.2's password:

Welcome to Ubuntu 18.04.1 LTS (GNU/Linux 4.13.0-46-generic x86_64)
tom@vps-container$ 
```

## Get port mapping

Unless you use `port` option, Docker will automatically bind container ssh port to a random port on host. To get this mapping, use following command:

```shell
$ docker port vps
22/tcp -> 0.0.0.0:32785
```

You can test connectivity from remote device

```shell
$ ssh $PUBLIC_IP$ -p 32785

tom@stargate.inetsix.net's password:

Welcome to Ubuntu 18.10 (GNU/Linux 4.13.0-46-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.

                  ___           ___           ___           ___                       ___
      ___        /\__\         /\  \         /\  \         /\  \          ___        |\__\
     /\  \      /::|  |       /::\  \        \:\  \       /::\  \        /\  \       |:|  |
     \:\  \    /:|:|  |      /:/\:\  \        \:\  \     /:/\ \  \       \:\  \      |:|  |
     /::\__\  /:/|:|  |__   /::\~\:\  \       /::\  \   _\:\~\ \  \      /::\__\     |:|__|__
  __/:/\/__/ /:/ |:| /\__\ /:/\:\ \:\__\     /:/\:\__\ /\ \:\ \ \__\  __/:/\/__/ ____/::::\__\
 /\/:/  /    \/__|:|/:/  / \:\~\:\ \/__/    /:/  \/__/ \:\ \:\ \/__/ /\/:/  /    \::::/~~/~
 \::/__/         |:/:/  /   \:\ \:\__\     /:/  /       \:\ \:\__\   \::/__/      ~~|:|~~|
  \:\__\         |::/  /     \:\ \/__/     \/__/         \:\/:/  /    \:\__\        |:|  |
   \/__/         /:/  /       \:\__\                      \::/  /      \/__/        |:|  |
                 \/__/         \/__/                       \/__/                     \|__|


    Important: Nothing will be backed up. Please ensure to use this instance as non permanent one

Last login: Sun Jan 13 21:54:34 2019 from 86.246.176.183
tom@a71406e0462d:~$
```

## Original Idea:
- [cloudposse / vps-ubuntu](https://github.com/cloudposse/vps-ubuntu)
