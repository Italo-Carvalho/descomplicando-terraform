module "servers" {
  source  = "./servers"
  blocks = var.blocks
  providers = {
    aws.west = aws.west
    aws      = aws
  }
}

output "ip_address" { # retorna os valores definidos
  value = module.servers.ip_address
}
