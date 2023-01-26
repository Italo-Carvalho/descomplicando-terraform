output "ip_address" { # retorna os valores definidos
  value = aws_instance.web[*].public_ip
}
