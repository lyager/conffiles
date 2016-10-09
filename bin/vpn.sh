#/bin/sh

if [ ! -z "$1" ]; then
	VPNHOST=$1
fi

if [ -z "${VPNHOST}" ]; then
	echo "Please set VPNHOST as a env-variable in the form: https://my.vpn.com/, or parse URI as argument"
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

rm -f /etc/resolver/labnet

