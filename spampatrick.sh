#!/usr/bin/env bash

echo "Initialising spam engine v1.0\n"

while true; do
	name=`shuf -n 1 names.txt`
	name_lower=`echo "$name" | tr '[:upper:]' '[:lower:]'`
	company=`shuf -n 1 companies.txt`
	company_lower=`echo "$company" | tr '[:upper:]' '[:lower:]'`
	suffix=`shuf -n 1 suffixes.txt`
	reason=`shuf -n 1 reasons.txt`

	curl 'http://patrickoboyle.com/send_contact_form_email.php' -H 'Host: patrickoboyle.com' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:49.0) Gecko/20100101 Firefox/49.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: http://patrickoboyle.com/' -H 'Cookie: _ga=GA1.2.1618244444.1475148100; _gat=1' -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1' --data "email=${name_lower}%40${company_lower}.${suffix}&reason=${reason}&message=Yo+waddup"

	printf "\n\nEmail sent from ${name_lower}@${company_lower}.${suffix}\n\n"

	sleep_time="0.0$(((RANDOM % 10) + 1))"
	for i in `seq 1 30`; do
		printf "."
		sleep "$sleep_time"
	done
done
