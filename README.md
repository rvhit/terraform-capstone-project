# Capstone Project: Blue-Green Zero-Downtime Deployment using Terraform
## Goal
Deploy a web app using Blue-Green strategy with zero downtime using AWS and Terraform.
## Tools Used
- AWS (EC2, ALB, VPC)
- Terraform
## Structure
- Blue and Green EC2 instances running Apache
- ALB routes traffic to Blue by default
- Manual switchover to Green using Terraform
## Steps to Reproduce
1. Clone the repo 
2. Unzip the files
3. Run `terraform init` and `terraform plan`
4. Run `terraform apply`
5. Access ALB DNS output to verify Blue
6. Switch to Green by editing `load_balancer.tf`, , resource `aws_lb_listener`
7. Run `terraform apply` again
8. Verify ALB now shows Green environment, without any downtime
## Author
Rohith Rathod