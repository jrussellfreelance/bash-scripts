#!/bin/bash
# This script monitors every website entry you put here.  For instance, an example would be:
# webmon.sh https://www.airkon992.com https://www.reddit.com
# Note: this script follows redirections. To disable them (and allow codes like "301"), delete the -L flag in curl.
for server in "${@}"; do
        http_code="$(curl -s -L -o /dev/null -I -w "%{http_code}" "${server}")"
        if [[ "${http_code}" -eq 200 ]]; then
                echo "${server} is up!"
        else
                echo "${server} is down. Sending email..."
                mail -s "${server}" "user.email@website.com" <<< "${server} is down"
        fi
done
