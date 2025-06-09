#!/bin/bash

set -e

STAGE=$1
if [[ -z "$STAGE" ]]; then
  echo "Usage: $0 <stage: dev|prod>"
  exit 1
fi

CONFIG_FILE="./config/${STAGE}.env"
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "Config file $CONFIG_FILE not found!"
  exit 1
fi

source "$CONFIG_FILE"
echo "Deploying to $STAGE environment..."

INSTANCE_ID=$(aws ec2 run-instances \
  --image-id "$AMI_ID" \
  --instance-type "$INSTANCE_TYPE" \
  --key-name "$KEY_NAME" \
  --security-groups "$SECURITY_GROUP" \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${STAGE}-App}]" \
  --query "Instances[0].InstanceId" --output text)

echo "Instance $INSTANCE_ID launching..."

aws ec2 wait instance-running --instance-ids "$INSTANCE_ID"
DNS=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" \
  --query "Reservations[0].Instances[0].PublicDnsName" --output text)

echo "Instance is running at $DNS"
echo "Waiting 30 seconds..."
sleep 30

echo "Setting up instance..."
ssh -o StrictHostKeyChecking=no -i my-key.pem ec2-user@"$DNS" <<EOF
  sudo yum update -y
  sudo yum install -y java-19-amazon-corretto git
  git clone $REPO_URL
  cd $APP_DIR
  sudo nohup java -jar app.jar > app.log 2>&1 &
EOF

echo "Testing application..."
sleep 10
if curl -s --head "http://$DNS" | grep "200 OK" > /dev/null; then
  echo "✅ App is live at http://$DNS"
else
  echo "❌ App failed to start"
fi

echo "Stopping instance to save cost..."
aws ec2 stop-instances --instance-ids "$INSTANCE_ID"
