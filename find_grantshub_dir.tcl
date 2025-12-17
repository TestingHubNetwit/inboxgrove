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

# Search for directory
send "find /root -maxdepth 2 -type d -name '*grant*' -o -name '*hub*'\r"
expect "#"

send "exit\r"
expect eof
