module "servers" {
  source  = "./servers"
  servers = 1
  providers = {
    aws = aws.west
  }
}

output "ip_address" { # retorna os valores definidos
  value = module.servers.ip_address
}
