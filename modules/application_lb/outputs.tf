output "id" {
  value = aws_lb.lb.id
}

output "arn" {
  value = aws_lb.lb.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.target.arn

}
