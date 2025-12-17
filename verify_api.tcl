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

# Check container status
send "docker compose ps\r"
expect "#"

# Check API logs for errors
send "docker compose logs api 2\u003e\u00261 | grep -i error | tail -10 || echo 'No errors found'\r"
expect "#"

# Check if API is responding
send "curl -s http://localhost:8002/docs \u003e /dev/null \u0026\u0026 echo 'API docs accessible' || echo 'API docs not accessible'\r"
expect "#"

# Check API version endpoint
send "curl -s http://localhost:8002/ || echo 'Root endpoint not accessible'\r"
expect "#"

# Check all containers
send "docker compose logs --tail=5 2\u003e\u00261\r"
expect "#"

send "exit\r"
expect eof
