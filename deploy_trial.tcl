#!/usr/bin/expect -f

set timeout 60
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

send "docker compose restart api\r"
expect "#"

send "sleep 5\r"
expect "#"

send "docker compose logs api | tail -10\r"
expect "#"

send "curl -s http://localhost:8002/docs | grep -o 'trial' | head -5 && echo '\r\n✅ Trial endpoints available' || echo '\r\n❌ Trial endpoints not found'\r"
expect "#"

send "exit\r"
expect eof
