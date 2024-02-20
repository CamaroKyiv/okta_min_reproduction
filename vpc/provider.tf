terraform {
  required_version = ">= 1.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.3.0"
    }
    okta = {
      source  = "okta/okta"
      version = "4.1.0"
    }
  }
}

provider "okta" {
  org_name  = "x_men_org"
  base_url  = "okta.com"
  api_token = jsondecode(data.aws_secretsmanager_secret_version.okta_key.secret_string)["key"]
}

terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "x_men_org"

    workspaces {
      prefix = "vpc-"
    }
  }
}
