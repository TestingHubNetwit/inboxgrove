#!/usr/bin/expect -f

set timeout 30
set host "94.250.203.249"
set user "root"
set password "aSecure9KeyA"
set remote_dir "/root/inboxgrove"

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

# Check if dist exists on host
send "ls -F $remote_dir/dist\r"
expect "#"

# Check inside container
send "docker exec inboxgrove_frontend ls -R /usr/share/nginx/html\r"
expect "#"

send "exit\r"
expect eof
