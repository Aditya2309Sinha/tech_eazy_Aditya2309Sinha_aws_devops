#!/bin/bash

# Save bucket name for shutdown use
echo "${bucket_name}" > /etc/mybucket.conf

# App Deployment
yum update -y
yum install -y java-19-openjdk git
cd /home/ec2-user
git clone https://github.com/<your-username>/<your-repo>.git
cd <your-repo>
nohup java -jar app.jar &> app.log &

# Save upload script
curl -o /usr/local/bin/upload-logs.sh https://raw.githubusercontent.com/<your-username>/<your-repo>/main/upload-logs.sh
chmod +x /usr/local/bin/upload-logs.sh
echo "/usr/local/bin/upload-logs.sh" >> /etc/rc0.d/K01uploadlogs
