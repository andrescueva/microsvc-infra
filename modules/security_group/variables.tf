variable "ingress_rules" {
  type        = map(any)
  description = "map of ingress rules"
}


variable "name" {
  type        = string
  description = "name of sg"
}


variable "vpc_id" {
  type = string
}
