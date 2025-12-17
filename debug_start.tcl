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

# Check potential conflict
send "docker port mailwizz-nginx\r"
expect "#"

# Try to start frontend interactively to see error
send "docker start -i inboxgrove_frontend\r"
expect "#"

send "exit\r"
expect eof
