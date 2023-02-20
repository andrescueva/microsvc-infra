variable "region" {
  description = "aws region "
}

variable "vpc_cidr" {
  description = "private ip block"
}

variable "task_container_port" {
  description = "port of containerr "
}

variable "ecs_cluster_name" {
  description = "name for ecs cluster"
}

variable "ecr_repo_name" {
  description = "name for ecr repo "
}

variable "task_memory" {
  description = "amount of memory in mb ej: 512, 1024"
}

variable "task_cpu" {
  description = "amount of cpu in miliCPU ej: 256"
}

variable "svc_min_capacity" {
  description = " min number of tasks as part of an ecs service"
}

variable "svc_max_capacity" {
  description = " max number of tasks as part of an ecs service"
}

variable "task_cpu_percentage_threshold" {
  description = "limit to start scaling out the tasks part of the ecs sevice"
}
