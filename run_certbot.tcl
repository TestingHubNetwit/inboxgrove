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

# Run Certbot via Gateway Compose
# We request a SINGLE certificate covering BOTH domains? Or separate? 
# Separate is cleaner usually, or single SAN.
# Let's try separate commands to avoid failure if one domain DNS is bad (though both should be good).
# Actually, I'll do one command first.

send "cd ~/gateway && docker compose run --rm certbot certonly --webroot --webroot-path /var/www/certbot --email nikhi@example.com --agree-tos --no-eff-email -d mailing.inboxgrove.com -d grant-app-frontend.amiigo.in\r"
expect "#"

send "exit\r"
expect eof
