output "endpoint" {
  value = aws_redshift_cluster.this.endpoint
}

output "cluster_id" {
  value = aws_redshift_cluster.this.id
}
