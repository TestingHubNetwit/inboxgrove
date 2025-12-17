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

# Get PID of process on port 80
send "netstat -tulpn | grep :80\r"
expect "#"

# Inspect that process to find container info (docker-proxy args usually have host-ip:port)
# If it is docker-proxy, we might not see container ID directly, but we can try to match.
# Alternative: docker inspect all containers and look for HostPort: 80

send "docker ps -q | xargs docker inspect --format '{{.Id}} {{.Name}} {{.NetworkSettings.Ports}}' | grep '80/tcp'\r"
expect "#"

send "exit\r"
expect eof
