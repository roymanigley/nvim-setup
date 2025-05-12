#!/bin/sh
chown -R $USERNAME:$USERNAME /home/$USERNAME/.config -R
cd /home/$USERNAME/
exec runuser -u $USERNAME -- "$@"
