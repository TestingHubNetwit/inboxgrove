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

# Check Env vars of the container
send "docker inspect inboxgrove_api --format '{{json .Config.Env}}'\r"
expect "#"

# Try to run via compose in foreground
send "cd inboxgrove && docker compose up api\r"
expect "#"

send "exit\r"
expect eof
