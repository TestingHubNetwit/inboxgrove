#!/usr/bin/expect -f

set timeout 90
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

send "cd ~/inboxgrove && git pull\r"
expect "#"

send "docker compose down frontend\r"
expect "#"

send "docker compose up -d --build frontend\r"
expect "#"

send "sleep 10 && docker compose ps | grep frontend\r"
expect "#"

send "exit\r"
expect eof
