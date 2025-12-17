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

# Stop all containers and REMOVE VOLUMES (to reset database)
send "docker compose down -v\r"
expect "#"

# Start fresh
send "docker compose up -d --build\r"
expect "#"

# Wait for startup
send "sleep 15\r"
expect "#"

# Check status
send "docker compose ps\r"
expect "#"

# Check API logs
send "docker compose logs api | tail -30\r"
expect "#"

# Test health
send "curl -s http://localhost:8002/health && echo '\r\nHealth check SUCCESS' || echo '\r\nHealth check FAILED'\r"
expect "#"

send "exit\r"
expect eof
