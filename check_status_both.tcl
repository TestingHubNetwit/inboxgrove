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

# Check panapp status
send "docker inspect panapp-frontend --format '{{.State.Status}} {{.State.Restarting}}'\r"
expect "#"

# Check inboxgrove status
send "docker inspect inboxgrove_frontend --format '{{.State.Status}} {{.State.ExitCode}}'\r"
expect "#"

send "exit\r"
expect eof
