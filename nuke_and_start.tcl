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

# Force remove conflict
send "docker rm -f panapp-frontend\r"
expect "#"

# Start all main services
send "docker start inboxgrove_api inboxgrove_kumo inboxgrove_celery_worker inboxgrove_celery_beat inboxgrove_frontend\r"
expect "#"

# Verify Running state
send "docker ps --filter name=inboxgrove_\r"
expect "#"

# Verify curl
send "curl -I http://mailing.inboxgrove.com\r"
expect "#"

send "exit\r"
expect eof
