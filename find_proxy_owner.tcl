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

# Check the proxy process args
send "ps -fp 1005349\r"
expect "#"

# Check all port mappings explicitly
send "docker ps --format '{{.Names}}' | xargs -I {} sh -c 'echo {}; docker port {}' | grep -B 1 ':80$'\r"
expect "#"

send "exit\r"
expect eof
