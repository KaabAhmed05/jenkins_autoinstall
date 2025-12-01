provider "aws" {
  region = "ap-south-1"
}


resource "aws_security_group" "day19_sg" {
  name = "my_sg"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "day19" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key
  vpc_security_group_ids = [aws_security_group.day19_sg.id]

  tags = {
    name = "jenkins_server"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/ap-south.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      # "sudo apt update",
      # "sudo apt install -y openjdk-11-jre",
      # "curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null",
      # "echo 'deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/' | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
      # "sudo apt-get update",
      # "sudo apt-get install -y jenkins"

      # "sudo apt update -y",
      # "sudo apt install -y fontconfig openjdk-17-jre",
      # "java -version",
      # "curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null",
      # "echo 'deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/' | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
      # "sudo apt-get update -y",
      # "sudo apt-get install -y jenkins",
      # "sudo systemctl enable jenkins",
      # "sudo systemctl start jenkins",
      # "sleep 10",
      #   "sudo systemctl status jenkins || true",

      "sudo apt update -y",
      "sudo apt install -y fontconfig openjdk-17-jre",
      "java -version",
      "curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null",
      "echo 'deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/' | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
      "sudo apt-get update -y",
      "sudo apt-get install -y jenkins",
      "sudo systemctl enable jenkins",
      "sudo systemctl start jenkins",
      "sleep 10",
      "sudo apt install -y docker.io",
      "sudo usermod -aG docker jenkins",
      "sudo usermod -aG docker ubuntu",
      "sudo systemctl restart docker",
      "sudo systemctl restart jenkins"


    ]
  }


  provisioner "local-exec" {

    command = "echo EC2 Public IP is ${self.public_ip} > jenkins_ip.txt"




  }


}

