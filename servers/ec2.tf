data "aws_ami" "ubuntu" { # Busca informações dentro do provider
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] # ubuntu
}

resource "aws_instance" "web" {
  count         = var.servers
  ami           = var.image_id
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}


# data "aws_ami" "ubuntu_west" { # Busca informações dentro do provider
#   most_recent = true
#   provider    = aws.west

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#   }

#   owners = ["099720109477"] # ubuntu
# }


# resource "aws_instance" "web_west" {
#   provider      = aws.west
#   ami           = data.aws_ami.ubuntu_west.id
#   instance_type = "t2.micro"

#   tags = {
#     Name = "HelloWorld"
#   }
# }
