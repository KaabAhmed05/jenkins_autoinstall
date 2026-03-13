-This is the code to download jenkins on an aws instance


  This project uses Terraform to automatically provision an AWS EC2 instance and configure a Jenkins CI/CD server with Docker and Ansible installed.

The infrastructure is created in the AWS Mumbai Region (ap-south-1) and automatically installs all required dependencies using Terraform provisioners.



-This Terraform configuration performs the following tasks:

1.Creates an AWS Security Group
2.Launches an EC2 Instance
3.Installs Java (OpenJDK 17)
4.Installs Jenkins
5.Installs Docker
6.Installs Ansible
7.Enables and starts Jenkins service
8.Adds required users to the Docker group
9.Outputs the EC2 public IP




-Technologies Used

Terraform
AWS EC2
Jenkins
Docker
Ansible
Ubuntu Server
Linux Shell Commands
