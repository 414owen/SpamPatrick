#!/usr/bin/env bash

# Taken from StackOverflow
urlencode() {
    # urlencode <string>
    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C
    
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done
    
    LC_COLLATE=$old_lc_collate
}

echo "Enter a message for Patrick (reading directly from stdin, so press ctrl-d some to finish)"
message=`urlencode "$(cat /dev/stdin)"`
echo "$message"

printf "Initialising spam engine v1.0\n\n"
names=`cat names.txt`
companies=`cat companies.txt`
suffixes=`cat suffixes.txt`
reasons=`cat reasons.txt`

while true; do
	name=`echo "$names" | shuf -n 1`
	name_email=`echo "$name" | tr '[:upper:]' '[:lower:]'`
	company=`echo "$companies" | shuf -n 1`
	company_email=`echo "$company" | tr '[:upper:]' '[:lower:]' | sed 's/\s//g'`
	suffix=`echo "$suffixes" | shuf -n 1`
	reason=`echo "$reasons" | shuf -n 1`

 	curl 'http://patrickoboyle.com/send_contact_form_email.php' -H 'Host: patrickoboyle.com' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:49.0) Gecko/20100101 Firefox/49.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: http://patrickoboyle.com/' -H 'Cookie: _ga=GA1.2.1618244444.1475148100; _gat=1' -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1' --data "email=${name_email}%40${company_email}.${suffix}&reason=${reason}&message=${message}"

	printf "\n\nEmail sent from ${name_email}@${company_email}.${suffix}\n\n"
	for i in `seq 1 50`; do
		printf "."
		sleep 0.1
	done
done
