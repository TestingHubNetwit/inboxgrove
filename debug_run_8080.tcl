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

# Get image name
send "docker images | grep frontend\r"
expect "#"

# Run it on 8080
send "docker run --rm --name debug_frontend -p 8080:80 inboxgrove-frontend\r"
# If it stays running, we won't get prompt back immediately.
# We expect to see Nginx logs or exit.
expect {
    "exited" { send "echo 'Exited'\r" }
    timeout { send "\x03" } 
}
expect "#"

send "exit\r"
expect eof
