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

# Create gateway directory
send "mkdir -p gateway\r"
expect "#"

send "exit\r"
expect eof

# SCP gateway files
spawn scp -r gateway/nginx.conf gateway/docker-compose.yml $user@$host:~/gateway/
expect {
    "password:" {
        send "$password\r"
    }
}
expect eof

# SCP updated InboxGrove docker-compose (to apply port change)
spawn scp docker-compose.yml $user@$host:~/inboxgrove/
expect {
    "password:" {
        send "$password\r"
    }
}
expect eof

# Deploy changes
spawn ssh $user@$host
expect {
    "password:" {
        send "$password\r"
    }
}
expect "#"

# 1. Bring down old InboxGrove (to free port 80)
send "cd inboxgrove && docker compose down inboxgrove_frontend\r"
expect "#"

# 2. Start Gateway
send "cd ~/gateway && docker compose up -d\r"
expect "#"

# 3. Start InboxGrove (on new port 8001)
# Service name is 'frontend', container name is 'inboxgrove_frontend'
send "cd ~/inboxgrove && docker compose up -d frontend\r"
expect "#"



send "exit\r"
expect eof
