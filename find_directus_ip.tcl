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

# Get Directus IP
send "docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' directus-app\r"
expect "#"

# Get Gateway Network
send "docker inspect gateway_nginx --format '{{json .NetworkSettings.Networks}}'\r"
expect "#"

send "exit\r"
expect eof
