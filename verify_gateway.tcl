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

# Verify GrantsHub Routing
send "curl -I -H 'Host: grant-app-frontend.amiigo.in' http://localhost\r"
expect "#"

# Verify InboxGrove Routing
send "curl -I -H 'Host: mailing.inboxgrove.com' http://localhost\r"
expect "#"

send "exit\r"
expect eof
