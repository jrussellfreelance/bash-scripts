#!/bin/sh
# pam_motd does not carry the environment
[ -f /etc/default/locale ] && . /etc/default/locale
export LANG
echo "-----------------------------------------------------------------------"
echo "| Hostname: srv.pulsifer.net | IP: 208.87.134.87 |                    |"
echo "-----------------------------------------------------------------------"
echo "  Important directories.:"
echo "  - /srv                : where the Wordpress and IWP files are located"
echo "  - /var/www/go         : where the TVM-Calculator-Go files are located"
echo ""
echo "  Important services....:"
echo "  - goapi.service       : the service that manages the TVM go api"
echo "  - srv-perms.service   : the service that manages folder permissions"
echo ""
echo "  Custom commands.......:"
echo "  - restart             : the service that manages the TVM go api"
cores=$(grep -c ^processor /proc/cpuinfo 2>/dev/null)
[ "$cores" -eq "0" ] && cores=1
threshold="${cores:-1}.0"
if [ $(echo "`cut -f1 -d ' ' /proc/loadavg` < $threshold" | bc) -eq 1 ]; then
echo "-----------------------------------------------------------------------"
echo "|                          system information                         |"
echo "-----------------------------------------------------------------------"
/usr/bin/landscape-sysinfo
echo "-----------------------------------------------------------------------"
else
echo "System information disabled due to load higher than $threshold"
fi