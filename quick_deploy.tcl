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

send "cd ~/inboxgrove && git pull && docker compose restart api\r"
expect "#"

send "sleep 5 && docker compose logs api | tail -5\r"
expect "#"

send "exit\r"
expect eof
