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

# List directories to find Grantshub
send "ls -F /root/\r"
expect "#"

# Check running containers to confirm name and port
send "docker ps --format '{{.Names}} {{.Ports}}'\r"
expect "#"

# Check for any existing nginx config on host
send "ls /etc/nginx/sites-enabled/ || echo 'No host nginx sites'\r"
expect "#"

send "exit\r"
expect eof
