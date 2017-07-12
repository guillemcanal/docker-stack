# Log DNS queries
log-queries

# Do not read from /etc/resolv.conf
no-resolv

# The default nameserver where DNS request are forwarded
server=${DNSMASQ_DNS}

# A regex that match domain starting with "dev."
# IMPORTANT : regexes MUST be wrapped between colons
address=/${DNSMASQ_LOCAL_DOMAIN}/${DNSMASQ_LOCAL_IP}
