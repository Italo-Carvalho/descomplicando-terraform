data "aws_ami" "ubuntu_west" { # Busca informações dentro do provider
  most_recent = true
  provider    = aws.west

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] # ubuntu
}


resource "aws_instance" "web_west" {
  for_each = toset(var.instance_types)

  ami           = data.aws_ami.ubuntu_west.id
  instance_type = each.value
  provider      = aws.west

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1.12",
      "sudo systemctl start nginx"
    ]
    connection {
      type = "ssh"
      host = self.associate_public_ip_address
      user = "ec2-user"
      private_key = file("terraform.pem")
    }
  }

  tags = {
    Name = "HelloWorld"
  }
  depends_on = [
    aws_instance.web
  ]

}

resource "aws_instance" "web" {
  count         = var.environment == "production" ? 2 + var.plus : 1
  ami           = var.image_id
  instance_type = count.index < 1 ? "t2.micro" : "t3.medium"
  vpc_security_group_ids = var.sg

  dynamic "ebs_block_device" {
    for_each = var.blocks
    content {
      device_name = ebs_block_device.value["device_name"]
      volume_size = ebs_block_device.value["volume_size"] # GiB
      volume_type = ebs_block_device.value["volume_type"]
      delete_on_termination = var.environment == "production" ? false : true
    }
  }

  tags = {
    Name = "HelloWorld"
    Env = var.environment
  }
}

resource "aws_eip" "ip" {
  vpc = true
  instance = aws_instance.web[0].id
}
