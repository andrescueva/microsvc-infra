variable "subnets" {
  type        = list(any)
  description = "list of subnets ids lb is connected to"
}



variable "security_groups" {
  type        = list(any)
  description = "ids of the security groups attached to lb"
}


variable "container_port" {
  type        = number
  description = "port of the target container "
}


variable "vpc_id" {
  type        = string
  description = "vpc id"

}
