provider "aws" {
  region  = terraform.workspace == "production" ? "us-west-1" : "us-west-2"
  version = "~> 4.0"
}

provider "aws" {
  alias   = "west"
  region  = "us-west-2"
  version = "~> 4.0"
}

terraform {
  backend "s3" {
    bucket         = "descomplicando-terraform-italo"
    dynamodb_table = "terraform-state-lock-dynamodb-lock-state" # Automaticamente habilita lock-state
    key            = "terraform-test.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
