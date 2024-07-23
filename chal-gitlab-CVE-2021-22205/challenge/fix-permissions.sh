#!/bin/bash

# Fix permissions
chown -R git:git /etc/gitlab /var/opt/gitlab /var/log/gitlab /etc/gitlab/ssh

# Reconfigure and restart GitLab
gitlab-ctl reconfigure
gitlab-ctl restart
