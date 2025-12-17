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
send "docker images | grep api\r"
expect "#"

# Run api interactively. We bypass entrypoint if needed, but let's try default first.
# We map no ports, just want to see stdout.
# We MUST load env vars from file or provide them? 
# docker-compose has env_file? 
# If it fails due to missing Env Vars, we will see it.
send "docker run --rm inboxgrove-api\r"
expect "#"

send "exit\r"
expect eof
