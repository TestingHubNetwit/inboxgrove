#!/usr/bin/expect -f

set timeout 30
set host "94.250.203.249"
set user "root"
set password "aSecure9KeyA"

# SCP updated nginx.conf
spawn scp gateway/nginx.conf $user@$host:~/gateway/
expect {
    "yes/no" {
        send "yes\r"
        exp_continue
    }
    "password:" {
        send "$password\r"
    }
}
expect eof

# Restart Gateway to apply changes
spawn ssh $user@$host
expect {
    "password:" {
        send "$password\r"
    }
}
expect "#"

send "cd ~/gateway && docker compose restart nginx-gateway\r"
expect "#"

send "exit\r"
expect eof
