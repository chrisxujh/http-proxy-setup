#!/bin/bash

CONFIG_FILE=/etc/squid/conf.d/my-squid.conf
ALLOW_IP=${1}

if [ -z $ALLOW_IP ]; then
	>&2 echo "Invalid arguments."
	>&2 echo "Usage: ${0} <allow_ip>"
	exit 1
fi

dpkg -s squid 1> /dev/null || exit 1;

# allow ip
> $CONFIG_FILE cat <<EOF
acl trustednet src $ALLOW_IP
http_access allow trustednet
EOF

echo "Finished configuration. Restarting squid server..."
systemctl restart squid
