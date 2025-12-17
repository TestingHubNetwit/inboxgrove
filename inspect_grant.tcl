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

# Inspect mounts to find source code
send "docker inspect grant-app-frontend --format '{{json .Mounts}}'\r"
expect "#"

# Inspect networks
send "docker inspect grant-app-frontend --format '{{json .NetworkSettings.Networks}}'\r"
expect "#"

# Check inboxgrove status again (briefly)
send "docker ps -a --filter name=inboxgrove_frontend\r"
expect "#"

send "exit\r"
expect eof
