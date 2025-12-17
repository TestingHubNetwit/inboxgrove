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

# Quick test - try direct container connection
send "docker exec gateway_nginx wget -O- http://172.28.0.9:8055 2>&1 | head -20\r"
expect "#"

# Check if directus is actually running
send "docker ps | grep directus\r"
expect "#"

send "exit\r"
expect eof
