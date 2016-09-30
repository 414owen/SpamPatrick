import requests, time, random, sys, itertools

def main():
    url="http://patrickoboyle.com/send_contact_form_email.php"

    base_message="Hi Patrick,at {} in Dublin. here at {}. If so, e when you're free. regards, {}, EMEA University recruiter"

    data={'send-copy': 'on'}

    names = None
    with open("names.txt") as f:
        names = list(filter(lambda a: a != "", f.read().split("\n")))

    companies = None
    with open("companies.txt") as f:
        companies = list(filter(lambda a: a != "", f.read().split("\n")))

    suffixes = None
    with open("suffixes.txt") as f:
        suffixes = list(filter(lambda a: a != "", f.read().split("\n")))

    reasons = None
    with open("reasons.txt") as f:
        reasons = list(filter(lambda a: a != "", f.read().split("\n")))

    dots_to_print = 30

    print("Initiating spam engine.\n")

    cookies = {
        "_ga": "GA1.2.1618244444.1475148100",
        "_gat": "1",
    }

    headers = {
        "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.101 Safari/537.36",
        "Upgrade-Insecure-Requests": "1",
        "Referer": "http://patrickoboyle.com/",
        "Origin": "http://patrickoboyle.com",
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
        "Accept-Encoding": "gzip, deflate",
        "Accept-Language": "en-US,en;q=0.8,en-GB;q=0.6",
        "Cache-Control": "max-age=0",
        "Connection": "keep-alive",
        "Content-Type": "application/x-www-form-urlencoded",
        "Host": "patrickoboyle.com",
    }

    while True:
        sleep_time = (random.random() * 10) / dots_to_print
        for x in range(0, dots_to_print):
            sys.stdout.write(".")
            sys.stdout.flush()
            time.sleep(sleep_time)
        print("\n")
        suffix = random.choice(suffixes)
        name = random.choice(names)
        company = random.choice(companies)
        email = "{}@{}.{}".format(name, company, suffix).lower().replace(" ", "")

        message = base_message.format(company, company, name)

        data['email'] = email
        data['message'] = message
        data['reason'] = random.choice(reasons)

        try:
            resp = requests.post(url, headers=headers, params=data, cookies=cookies)
            print("Email sent from: {}\n{}\n".format(email, resp))
        except a: 
            print("Exception was raised, waiting a minute, in case I'm accidentally DDOSing Patrick" + a)
            time.sleep(60)

if __name__ == "__main__":
    main()
