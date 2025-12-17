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

# Check container status
send "docker ps -a\r"
expect "#"

# Check logs again (sometimes helps to be explicit)
send "docker logs inboxgrove_frontend\r"
expect "#"

# Inspect the container to see why it died
send "docker inspect inboxgrove_frontend --format='{{.State.ExitCode}} {{.State.Error}}'\r"
expect "#"

send "exit\r"
expect eof
