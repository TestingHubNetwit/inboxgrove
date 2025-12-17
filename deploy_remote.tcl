#!/usr/bin/expect -f

set timeout -1
set host "94.250.203.249"
set user "root"
set password "aSecure9KeyA"
set file "inboxgrove_deploy.zip"
set remote_dir "/root/inboxgrove"

# Step 1: Upload the zip file
spawn scp $file $user@$host:$file
expect {
    "yes/no" {
        send "yes\r"
        exp_continue
    }
    "password:" {
        send "$password\r"
    }
}
expect eof

# Step 2: SSH and deploy
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

# Install unzip if missing
send "apt-get update && apt-get install -y unzip\r"
expect "#"

# Create directory and unzip
send "rm -rf $remote_dir && mkdir -p $remote_dir\r"
expect "#"
send "mv $file $remote_dir/\r"
expect "#"
send "cd $remote_dir\r"
expect "#"
send "unzip -o $file\r"
expect "#"

# Install Docker if missing
send "which docker || curl -fsSL https://get.docker.com | sh\r"
expect "#"

# Deploy
send "docker compose down --remove-orphans\r"
expect "#"
send "docker compose up -d --build\r"
expect "#"

# Cleanup
send "rm $file\r"
expect "#"
send "exit\r"
expect eof
