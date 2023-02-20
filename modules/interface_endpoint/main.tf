resource "aws_vpc_endpoint" "svc" {
  for_each = var.services
  vpc_id   = var.vpc_id

  service_name        = each.value.name
  vpc_endpoint_type   = "Interface"
  security_group_ids  = var.sgs
  private_dns_enabled = true
  ip_address_type     = "ipv4"
  subnet_ids          = var.subnets
  # policy defaults to full access
  # to do: use specific policy

}
