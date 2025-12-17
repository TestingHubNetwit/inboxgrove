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

send "docker compose down\r"
expect "#"

send "docker compose up -d --build\r"
expect "#"

send "sleep 20\r"
expect "#"

send "docker compose ps\r"
expect "#"

send "docker compose logs api | tail -20\r"
expect "#"

send "curl -s http://localhost:8002/docs \u003e /dev/null \u0026\u0026 echo '\r\n✅ API DOCS ACCESSIBLE' || echo '\r\n❌ API DOCS FAILED'\r"
expect "#"

send "curl -s http://localhost:8002/ \u0026\u0026 echo '\r\n✅ API ROOT ACCESSIBLE' || echo '\r\n❌ API ROOT FAILED'\r"
expect "#"

send "curl -s http://localhost:3013 \u003e /dev/null \u0026\u0026 echo '\r\n✅ FRONTEND ACCESSIBLE' || echo '\r\n❌ FRONTEND FAILED'\r"
expect "#"

send "exit\r"
expect eof
