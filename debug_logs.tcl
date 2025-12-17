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

# Check permissions
send "docker run --rm --entrypoint ls inboxgrove-frontend -l /usr/share/nginx/html\r"
expect "#"

# Check config content
send "docker run --rm --entrypoint cat inboxgrove-frontend /etc/nginx/conf.d/default.conf\r"
expect "#"

send "exit\r"
expect eof
