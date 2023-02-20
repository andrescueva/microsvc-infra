provider "aws" {
  region = var.region
}


module "network" {
  source   = "../modules/network"
  vpc_cidr = var.vpc_cidr
}


module "sg_lb" {
  source = "../modules/security_group"
  vpc_id = module.network.vpc_id
  ingress_rules = {
    "all" : {
      description  = "http lb",
      from_port    = 80,
      to_port      = 80,
      protocol     = "tcp",
      sources_ipv4 = ["0.0.0.0/0"],
      sources_ipv6 = []
    }
  }
  name = "allow all to application lb"
}


module "sg_vpc_internal" {
  source = "../modules/security_group"
  vpc_id = module.network.vpc_id
  ingress_rules = {
    "all" : {
      description  = "all example",
      from_port    = 0,
      to_port      = 0,
      protocol     = "-1",
      sources_ipv4 = [var.vpc_cidr],
      sources_ipv6 = []
    }
  }
  name = "allow all - only internal"
}


module "lb" {
  source          = "../modules/application_lb"
  vpc_id          = module.network.vpc_id
  container_port  = var.container_port
  security_groups = [module.sg_lb.id]
  subnets         = [module.network.public_subnet1_id, module.network.public_subnet2_id]

}


module "ecs" {
  source = "../modules/ecs"
  name   = "ecs"
}


module "ecs_service" {
  source          = "../modules/ecs_service"
  container_port  = var.container_port
  security_groups = [module.sg_vpc_internal.id]
  #subnets = [module.network.public_subnet1_id, module.network.public_subnet2_id]
  subnets                       = [module.network.private_subnet1_id, module.network.private_subnet2_id]
  lb_target_group_arn           = module.lb.target_group_arn
  ecs_cluster_id                = module.ecs.id
  ecs_cluster_name              = var.ecs_cluster_name
  task_memory                   = 512
  task_cpu                      = 256
  min_capacity                  = 2
  max_capacity                  = 3
  task_cpu_percentage_threshold = 80

}


module "ecr" {
  source = "../modules/ecr"
  name   = "microsvc"
}


module "interface_endpoint" {
  source = "../modules/interface_endpoint"
  vpc_id = module.network.vpc_id
  services = {
    "ecr-api1" : {
      name = "com.amazonaws.${var.region}.ecr.api"
    },
    "ecr-dkr1" : {
      name = "com.amazonaws.${var.region}.ecr.dkr"
    }
  }
  subnets = [module.network.private_subnet1_id, module.network.private_subnet2_id]
  sgs     = [module.sg_vpc_internal.id]
}


resource "aws_vpc_endpoint" "s3" {
  vpc_id            = module.network.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  route_table_ids   = [module.network.private_route_table_id]
  vpc_endpoint_type = "Gateway"
}
