resource "aws_eip" "lb" {
  vpc = true
  count = 1
}

resource "null_resource" "ip_check"{
    # Quando muda força o null_resource a re-executar, re-running qualuqer provisioners associados
    triggers = {
        latest_ips = join(",", aws_eip.lb[*].public_ip)
    }

    provisioner "local-exec" {
      command = "echo Latest IPs are ${null.resource.ip_check.triggers.laster_ips} > sample.txt"
    }
}