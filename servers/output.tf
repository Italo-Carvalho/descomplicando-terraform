output "ip_address" { # retorna os valores definidos
  # web_ip = aws_instance.web[*].public_ip # count

  value = {
    for instance in aws_instance.web_west: # for_earch
    instance.id => instance.private_ip
  }
}
/**
output:
  "ip_address" {
    "i-032131231231" = "172.31.14.192"
    "i-0dvos2123213" = "172.31.0.188"
  }
**/