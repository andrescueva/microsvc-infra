output "vpc_arn" {
  value = aws_vpc.main.arn
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet1_id" {
  value = aws_subnet.private_subnet1.id
}

output "private_subnet2_id" {
  value = aws_subnet.private_subnet2.id
}

output "public_subnet1_id" {
  value = aws_subnet.public_subnet1.id
}

output "public_subnet2_id" {
  value = aws_subnet.public_subnet2.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id

}

output "public_route_table_id" {
  value = aws_route_table.public.id

}
