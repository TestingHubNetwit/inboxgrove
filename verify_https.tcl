#!/usr/bin/expect -f

set timeout 30
set host "94.250.203.249"
set user "root"
set password "aSecure9KeyA"

spawn ssh $user@$host
expect {
    "yes/no" {
        send "yes\r"
        exp_continue
    }
    "password:" {
        send "$password\r"
    }
}
expect "#"

# 1. Verify HTTPS GrantsHub (using -k for self-signed or if internal curl fails valid chain, but let's try with -k to verify connection logic first. 
# Actually, LetsEncrypt is valid public cert. Server curl might not have updated CA store, but usually fine.
send "curl -I https://grant-app-frontend.amiigo.in --resolve grant-app-frontend.amiigo.in:443:127.0.0.1\r"
expect "#"

# 2. Verify HTTPS InboxGrove
send "curl -I https://mailing.inboxgrove.com --resolve mailing.inboxgrove.com:443:127.0.0.1\r"
expect "#"

# 3. Verify Redirect
send "curl -I http://mailing.inboxgrove.com --resolve mailing.inboxgrove.com:80:127.0.0.1\r"
expect "#"

send "exit\r"
expect eof
