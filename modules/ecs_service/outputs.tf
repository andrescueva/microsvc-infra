
output "id" {
  value = aws_ecs_service.svc.id
}

output "task_role_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}
