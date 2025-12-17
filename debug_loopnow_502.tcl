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

# Check if port 8055 is open on host
send "netstat -tulpn | grep :8055 || echo 'netstat failed'\r"
expect "#"

# Try to connect to 8055 from host
send "curl -I http://localhost:8055\r"
expect "#"

# Check directus logs
send "docker logs directus-app --tail 20\r"
expect "#"

# Check Gateway logs
send "docker logs gateway_nginx --tail 20\r"
expect "#"

send "exit\r"
expect eof
