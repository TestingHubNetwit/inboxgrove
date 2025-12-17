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

# Check Nginx error log file directly
send "docker exec inboxgrove_frontend cat /var/log/nginx/error.log\r"
expect "#"

# Check access log
send "docker exec inboxgrove_frontend tail -n 20 /var/log/nginx/access.log\r"
expect "#"

# Verify permissions of the path components
send "docker exec inboxgrove_frontend ls -ld /usr /usr/share /usr/share/nginx /usr/share/nginx/html\r"
expect "#"

# Verify default.conf matches what we expect
send "docker exec inboxgrove_frontend cat /etc/nginx/conf.d/default.conf\r"
expect "#"

# Test connection locally inside container
send "docker exec inboxgrove_frontend wget -O - -S http://localhost/ || docker exec inboxgrove_frontend curl -v http://localhost/\r"
expect "#"

send "exit\r"
expect eof
