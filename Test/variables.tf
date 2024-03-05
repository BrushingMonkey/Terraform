data "aws_ami" "ubuntu_ami" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "Ubuntu Linux"
    values = ["al2023-ami-*-kernel-6.1-x86_64"]
  }
}

data "aws_ami" "redhat_ami" {
  most_recent      = true
  owners           = ["351922839466"]

  filter {
    name   = "Redhat Linux"
    values = ["al2023-ami-*-kernel-6.1-x86_64"]
  }
}

variable "redhat_ami" {
  description = "ami for Redhat"
  type = string
  default = "ami-08e592fbb0f535224"
}

variable "allow_ports" {
  description = "list of ports to allow"
  type = list
  default = ["22", "80", "443"]
}

variable "instance_type" {
  description = "ec2 instance type"
  type = string
  default = "t2.micro"
}

