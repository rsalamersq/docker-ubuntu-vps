# Ubuntu Docker VPS

Docker container to provide VPS using latest version of Ubuntu

Usage:

```shell
stargate :: ~/docker-git/docker-ubuntu-vps » docker run -d -P --name vps -e VPS_USER=tom -e VPS_PASSWORD=passowrd inetsix/ubuntu-vps
2f73b132811ae82a56c9047453ffd8b740211cfbde3e83d5ea7abef3ccf5de5c

stargate :: ~/docker-git/docker-ubuntu-vps » docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' vps
172.17.0.2

stargate :: ~/docker-git/docker-ubuntu-vps » ssh 172.17.0.2 -l tom                                                                                                                                                                                                   130 ↵

The authenticity of host '172.17.0.2 (172.17.0.2)' can't be established.
ECDSA key fingerprint is SHA256:Q1U1F8zgX25tgcGWJucMa0IR+hbT1subwFGFmLoKXrk.
Are you sure you want to continue connecting (yes/no)? yes
Failed to add the host to the list of known hosts (/home/tom/.ssh/known_hosts).
tom@172.17.0.2's password:

Welcome to Ubuntu 18.04.1 LTS (GNU/Linux 4.13.0-46-generic x86_64)
...
```


Original Idea:
- [cloudposse / ubuntu-vps](https://github.com/cloudposse/ubuntu-vps)
