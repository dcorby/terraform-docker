provider "aws" {
  region = "us-east-2"
}

variable "server_port" {
  description = "port to use"
  type        = number
  default     = 8080
}

resource "aws_instance" "example" {
  ami           = "<ami>"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              docker run --rm -d -p 8080:8080 <image>
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "example"
  }
}

resource "aws_security_group" "instance" {
  name = "example-instance"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "public IP"
}
