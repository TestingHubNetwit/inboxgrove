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

# Check frontend exit code
send "docker inspect inboxgrove_frontend --format '{{.State.ExitCode}}'\r"
expect "#"

# Check full logs
send "docker logs inboxgrove_frontend\r"
expect "#"

send "exit\r"
expect eof
