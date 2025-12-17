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

# Check Grantshub on 4000
send "curl -I http://localhost:4000\r"
expect "#"

# Check if port 80 is actually free now (running netstat)
send "netstat -tulpn | grep :80\r"
expect "#"

send "exit\r"
expect eof
