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

# Search for directus container
send "docker ps --format '{{.Names}} {{.Ports}}' | grep directus\r"
expect "#"

# Search specifically for anything running on likely ports or named loopnow just in case
send "docker ps --format '{{.Names}} {{.Ports}}' | grep loopnow\r"
expect "#"

send "exit\r"
expect eof
