#!/bin/sh
chown -R $USERNAME:$USERNAME /home/$USERNAME/ -R
cd /home/$USERNAME/
exec runuser -u $USERNAME -- "$@"
