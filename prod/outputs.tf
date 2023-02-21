output "ecs_task_role_arn" {
  value = module.ecs_service.task_role_arn
}

output "ecr_repository_url" {
  value = module.ecr.url
}

output "lb_dns_name" {
  value = module.lb.dns_name
}
