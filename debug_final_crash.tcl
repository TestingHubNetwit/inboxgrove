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

# Check API logs
send "docker logs inboxgrove_api\r"
expect "#"

# Check Frontend logs
send "docker logs inboxgrove_frontend\r"
expect "#"

# Check panapp again
send "docker ps | grep panapp\r"
expect "#"

send "exit\r"
expect eof
