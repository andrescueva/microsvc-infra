region                        = "eu-west-1"
vpc_cidr                      = "172.30.0.0/16"
ecs_cluster_name              = "ecs"
ecr_repo_name                 = "microsvc"
task_container_port           = 8000
task_memory                   = 512
task_cpu                      = 256
svc_min_capacity              = 2
svc_max_capacity              = 3
task_cpu_percentage_threshold = 80
