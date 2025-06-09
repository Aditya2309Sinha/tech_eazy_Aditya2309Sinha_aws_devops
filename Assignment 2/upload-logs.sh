#!/bin/bash
BUCKET=$(cat /etc/mybucket.conf)
aws s3 cp /var/log/cloud-init.log s3://$BUCKET/system-logs/
aws s3 cp /home/ec2-user/<your-repo>/app.log s3://$BUCKET/app/logs/
