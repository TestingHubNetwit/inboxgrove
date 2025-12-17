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

# Verify LoopNow HTTPS
send "curl -I https://app.loopnow.in --resolve app.loopnow.in:443:127.0.0.1\r"
expect "#"

send "exit\r"
expect eof
