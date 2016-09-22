#/bin/sh

if [ -z "${VPNHOST}" ]; then
	echo "Pleast set VPNHOST as a env-variable in the form: https://my.vpn.com/"
	exit 1
fi

if [ ! -d '/etc/resolver' ]; then
      mkdir /etc/resolver
fi

cat > /etc/resolver/labnet <<EOF
nameserver 10.10.10.10
timeout10
EOF

openconnect --juniper ${VPNHOST}

rm /etc/resolver/labnet

