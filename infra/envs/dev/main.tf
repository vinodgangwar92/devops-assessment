terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "../../modules/network"

  environment        = "dev"
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
}
module "ecs" {
  source = "../../modules/ecs"

  environment            = "dev"
  vpc_id                 = module.network.vpc_id
  public_subnet_ids      = module.network.public_subnet_ids
  private_app_subnet_ids = module.network.private_app_subnet_ids
  db_host                = module.rds.rds_endpoint
  db_name                = "hotel_booking"
  db_user                = "postgres"
  db_password            = var.db_password
}
module "rds" {
  source = "../../modules/rds"

  environment             = "dev"
  vpc_id                  = module.network.vpc_id
  private_db_subnet_ids   = module.network.private_db_subnet_ids
  ecs_security_group_id   = module.ecs.ecs_security_group_id
  instance_class          = "db.t3.micro"
  backup_retention_period = 1
  deletion_protection     = false
}

