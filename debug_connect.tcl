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

# Check container status and ports
send "docker ps --filter name=inboxgrove_frontend --format '{{.Status}} {{.Ports}}'\r"
expect "#"

# Check if port 80 is listening on host
send "netstat -tulpn | grep :80\r"
expect "#"

# Test internal connection
send "curl -I localhost\r"
expect "#"

send "exit\r"
expect eof
