output "cluster_id" {
  description = "ECS cluster ID -- currently plain on-demand Fargate (see this scenario's README for why Spot/FARGATE_SPOT isn't wired in yet)."
  value       = module.ecs_service.cluster_id
}
