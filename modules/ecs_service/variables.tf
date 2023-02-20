variable "container_port" {
  type        = number
  description = "port of backend containers"

}

variable "lb_target_group_arn" {
  type        = string
  description = " target group attached to lb that will expose the service"
}


variable "security_groups" {
  type        = list(any)
  description = "list of security groups attached to service"
}


variable "subnets" {
  type        = list(any)
  description = "list of subnets the serivce is connected to"
}


variable "ecs_cluster_id" {
  type        = string
  description = "id of cluster ecs to run service"
}


variable "task_memory" {
  type        = number
  default     = 512
  description = "amount of memory to assign to task"

}

variable "task_cpu" {
  type        = number
  default     = 256
  description = "amount of cpu to assign to task"
}

variable "min_capacity" {
  type        = number
  default     = 1
  description = "min number of task to run within service"
}

variable "max_capacity" {
  type        = number
  default     = 1
  description = "max number of task to run within service"
}


variable "ecs_cluster_name" {
  type        = string
  description = "ecs name"
}


variable "task_cpu_percentage_threshold" {
  type = number
  description = "task_cpu_percentage_threshold"
}
