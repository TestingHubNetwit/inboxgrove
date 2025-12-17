#!/usr/bin/expect -f

set timeout 120
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

send "cd ~/inboxgrove\r"
expect "#"

send "git pull\r"
expect "#"

send "docker compose down frontend\r"
expect "#"

send "docker compose up -d --build frontend\r"
expect "#"

send "sleep 10\r"
expect "#"

send "docker compose ps\r"
expect "#"

send "curl -s http://localhost:3013 > /dev/null && echo '✅ Frontend accessible' || echo '❌ Frontend failed'\r"
expect "#"

send "exit\r"
expect eof
