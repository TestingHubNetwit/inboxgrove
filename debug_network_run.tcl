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

# Check network of API
send "docker inspect inboxgrove_api --format '{{json .NetworkSettings.Networks}}'\r"
expect "#"

# Check network of Frontend (even if stopped)
send "docker inspect inboxgrove_frontend --format '{{json .NetworkSettings.Networks}}'\r"
expect "#"

# Run frontend interactively (foreground) to see it crash or stay up
send "docker start -a inboxgrove_frontend\r"
# If it stays up, it won't return prompt quickly. We timeout after 10s and check if it's still running?
# Or just let it run for a bit.
expect {
    "Configuration complete" {
        send_user "\nCaptured config complete\n"
        # Wait to see if it crashes
        expect {
            "emerg" { send_user "\nCRASH DETECTED\n" }
            timeout { send_user "\nSTILL RUNNING (Timeout)\n"; send "\x03" }
        }
    }
    timeout { send_user "\nTIMEOUT STARTING\n"; send "\x03" }
}

send "exit\r"
expect eof
