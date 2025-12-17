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

# Navigate to project
send "cd ~/inboxgrove\r"
expect "#"

# Pull latest changes
send "git pull\r"
expect "#"

# Stop all containers
send "docker compose down\r"
expect "#"

# Start containers
send "docker compose up -d --build\r"
expect "#"

# Wait a bit for startup
send "sleep 10\r"
expect "#"

# Check API logs
send "docker compose logs api | tail -50\r"
expect "#"

# Check container status
send "docker compose ps\r"
expect "#"

# Try to access health endpoint
send "curl -s http://localhost:8002/health || echo 'Health check failed'\r"
expect "#"

send "exit\r"
expect eof
