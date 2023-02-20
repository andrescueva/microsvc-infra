variable "region" {
  default = "eu-west-1"
}

variable "vpc_cidr" {
  default = "172.30.0.0/16"
}

variable "container_port" {
  default = 8000
}

variable "ecs_cluster_name" {
  default = "ecs"
}
