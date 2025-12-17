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

# Create .env file with dummy values for required fields
# Based on pydantic errors seen earlier (Step 406)
send "cat > inboxgrove/.env <<EOF
POSTGRES_USER=inboxgrove_user
POSTGRES_PASSWORD=secure_password_change_me
POSTGRES_DB=inboxgrove
DB_PASSWORD=secure_password_change_me
DATABASE_URL=postgresql://inboxgrove_user:secure_password_change_me@postgres:5432/inboxgrove
REDIS_URL=redis://redis:6379/0
CELERY_BROKER_URL=redis://redis:6379/1
CELERY_RESULT_BACKEND=redis://redis:6379/2
CLOUDFLARE_API_TOKEN=dummy_token
CLOUDFLARE_ZONE_ID=dummy_zone
GOOGLE_CLIENT_ID=dummy_client_id
GOOGLE_CLIENT_SECRET=dummy_client_secret
KUMOMTA_API_URL=http://kumo:8008
SECRET_KEY=change-me-in-production
ENCRYPTION_KEY=change-me-aes256-key
LOG_LEVEL=INFO
MAIL_SMTP_HOST=smtp.example.com
MAIL_SMTP_USER=user
MAIL_SMTP_PASSWORD=password
KUMO_API_URL=http://kumo:8008
KUMO_API_KEY=dummy
KUMO_PASSWORD=dummy
EOF
\r"
expect "#"

# Restart API
send "cd inboxgrove && docker compose up -d api\r"
expect "#"

# Check logs
send "docker logs inboxgrove_api --tail 20\r"
expect "#"

send "exit\r"
expect eof
