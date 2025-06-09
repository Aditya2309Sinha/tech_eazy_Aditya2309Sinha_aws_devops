# tech_eazy_Aditya2309Sinha_aws_devops

# 🚀 EC2 Deployment Automation — DevOps Assignment

This project automates the deployment of a Java application to an AWS EC2 instance using a Bash script. It supports stage-based configuration (Dev/Prod), installs dependencies, deploys a GitHub-hosted app, and shuts down the instance to avoid costs.

---

## ✅ Features

- 🔄 Spins up an EC2 instance based on stage-specific configuration (`dev` or `prod`)
- ☕ Installs Java 19 and Git automatically
- 📂 Clones a specified GitHub repository and launches the app
- 🌐 Checks if the app is running on port 80
- 💸 Stops the instance after deployment to minimize costs
- 🔐 Uses environment variables for AWS credentials (no secrets in code)
- 📁 Makes instance type, dependencies, and repo URL configurable

- Provide:

  -AWS Access Key ID
  -AWS Secret Access Key
  -Default region (e.g., ap-south-1)
  -Output format: json

-Change:
  -KEY_NAME=
  -SECURITY_GROUP=
  -REPO_URL=https://github.com/<your-username>/<your-repo>.git
  -APP_DIR=<your-repo-name>

