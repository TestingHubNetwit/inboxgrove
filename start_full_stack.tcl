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

# Run docker compose up -d to start all services
send "cd inboxgrove && docker compose up -d\r"
expect "#"

# Check status of all containers (filtered by our prefix)
send "docker ps --filter name=inboxgrove_\r"
expect "#"

send "exit\r"
expect eof
