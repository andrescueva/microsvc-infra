variable "services" {
  type        = map(any)
  description = "list of aws services to create interface endpoints for"
}

variable "sgs" {
  type        = list(any)
  description = "list of sg ids to add to interface endpoint"
}


variable "subnets" {
  type        = list(any)
  description = "list of subnet ids to connect the interface endpoint"
}


variable "vpc_id" {
  type        = string
  description = "id of vpc where it is connected"
}
