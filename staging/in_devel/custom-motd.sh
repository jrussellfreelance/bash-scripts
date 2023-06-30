#!/bin/bash
[ -f /etc/default/locale ] && . /etc/default/locale
export LANG
# original state was a symbolic link to /usr/share/landscape/landscape-sysinfo.wrapper 
echo ""
echo "  Hostname..............: srv.pulsifer.net"
echo "  Public IP.............: 208.87.134.87"
echo ""
echo "  Important directories.:"
echo "   - /srv               : where the Wordpress and IWP files are located"
echo "   - /var/www/go        : where the TVM-Calculator-Go files are located"
echo ""
echo "  Important services....:"
echo "   - goapi.service      : manages the TVM-Calculator-Go app"
echo "   - iwp-perms.service  : manages InfiniteWP's ownership/permissions"
echo "   - wp-perms.service   : manages the Wordpress sites' ownership/permissions"
echo ""
echo "  Custom commands.......:"
echo "   - restart_wp         : restarts all Wordpress docker containers"
echo ""
cores=$(grep -c ^processor /proc/cpuinfo 2>/dev/null)
[ "$cores" -eq "0" ] && cores=1
threshold="${cores:-1}.0"
if [ $(echo "`cut -f1 -d ' ' /proc/loadavg` < $threshold" | bc) -eq 1 ]; then
echo "  System information....:"
/usr/bin/landscape-sysinfo | grep -v IPv4 | grep -v IPv6 | sed -e 's/^[[:space:]]*//' | sed -e 's/://' | awk '{print "   - " $0}'
echo ""
else
echo "  System information disabled due to load higher than $threshold"
echo ""
fi