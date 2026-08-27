resource "aws_dms_replication_subnet_group" "this" {
  replication_subnet_group_id          = "${var.name}-subnet-group"
  replication_subnet_group_description = "${var.name} DMS subnet group"
  subnet_ids                           = var.private_subnet_ids
  tags                                 = var.tags
}

# The compute that actually runs the migration/replication task — separate
# from the source/target endpoints below, which just describe where data
# comes from and goes to.
resource "aws_dms_replication_instance" "this" {
  replication_instance_id     = var.name
  replication_instance_class  = var.replication_instance_class
  replication_subnet_group_id = aws_dms_replication_subnet_group.this.id
  publicly_accessible         = false

  tags = var.tags
}

# The source database DMS reads change data from. See this module's README
# for why source_password is a plain variable here (and why that's a
# tradeoff, not the ideal end state).
resource "aws_dms_endpoint" "source" {
  endpoint_id   = "${var.name}-source"
  endpoint_type = "source"
  engine_name   = var.source_engine_name
  server_name   = var.source_server_name
  port          = var.source_port
  database_name = var.source_database_name
  username      = var.source_username
  password      = var.source_password

  tags = var.tags

  # A bad port number would fail at connection time with a much less
  # specific error than this.
  lifecycle {
    precondition {
      condition     = var.source_port > 0 && var.source_port <= 65535
      error_message = "source_port must be a valid TCP port (1-65535)."
    }
  }
}

# The target DMS writes captured changes to. Defaults to Kafka (pairs with
# msk-kafka's bootstrap_brokers_tls output) since that's what cdc-pipeline
# uses — swap target_engine_name for other targets, but note the
# kafka_settings block below would need to change too.
resource "aws_dms_endpoint" "target" {
  endpoint_id   = "${var.name}-target"
  endpoint_type = "target"
  engine_name   = var.target_engine_name

  kafka_settings {
    broker                  = var.target_kafka_broker
    include_control_details = true
  }

  tags = var.tags
}

# full-load-and-cdc: does the initial bulk copy AND keeps streaming ongoing
# changes afterward — as opposed to full-load (one-time copy only) or cdc
# (changes only, assumes the target already has the initial data).
resource "aws_dms_replication_task" "this" {
  replication_task_id      = var.name
  replication_instance_arn = aws_dms_replication_instance.this.replication_instance_arn
  source_endpoint_arn      = aws_dms_endpoint.source.endpoint_arn
  target_endpoint_arn      = aws_dms_endpoint.target.endpoint_arn
  migration_type           = "full-load-and-cdc"
  table_mappings           = var.table_mappings

  tags = var.tags
}
