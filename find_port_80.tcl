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

# Find container on port 80
send "docker ps --format '{{.ID}} {{.Ports}} {{.Names}}' | grep ':80->'\r"
expect "#"

# Also list all to be safe
send "docker ps --format '{{.ID}} {{.Names}} {{.Status}}'\r"
expect "#"

send "exit\r"
expect eof
