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

# Check conflicts
send "docker ps | grep panapp\r"
expect "#"
send "netstat -tulpn | grep :80\r"
expect "#"

# Force start API
send "docker start inboxgrove_api\r"
expect "#"
send "docker logs inboxgrove_api --tail 10\r"
expect "#"

# Force start Frontend
send "docker start inboxgrove_frontend\r"
expect "#"
send "docker logs inboxgrove_frontend --tail 10\r"
expect "#"

send "exit\r"
expect eof
