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

# Check API status and logs
send "docker inspect inboxgrove_api --format '{{.State.Status}} {{.State.ExitCode}}'\r"
expect "#"
send "docker logs inboxgrove_api --tail 10\r"
expect "#"

# Check Frontend status and logs
send "docker inspect inboxgrove_frontend --format '{{.State.Status}} {{.State.ExitCode}}'\r"
expect "#"
send "docker logs inboxgrove_frontend --tail 10\r"
expect "#"

# Check connectivity
send "curl -I http://mailing.inboxgrove.com\r"
expect "#"

send "exit\r"
expect eof
