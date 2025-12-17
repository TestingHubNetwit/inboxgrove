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

# Start Frontend
send "docker start inboxgrove_frontend\r"
expect "#"

# Wait
send "sleep 5\r"
expect "#"

# Check status
send "docker ps --filter name=inboxgrove_\r"
expect "#"

# Check Curl
send "curl -I http://mailing.inboxgrove.com || curl -I localhost\r"
expect "#"

send "exit\r"
expect eof
