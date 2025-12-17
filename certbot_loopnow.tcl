#!/usr/bin/expect -f

set timeout 120
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

# Run Certbot for LoopNow
send "cd ~/gateway && docker compose run --rm certbot certonly --webroot --webroot-path /var/www/certbot --email nikhi@example.com --agree-tos --no-eff-email -d app.loopnow.in\r"
expect "#"

send "exit\r"
expect eof
