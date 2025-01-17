#!/bin/bash
echo Port 7153 >> /etc/ssh/sshd_config
systemctl restart sshd.service
