module "vpc" {
  source = "../../modules/vpc"

  name               = var.name
  availability_zones = var.availability_zones
}

module "source_db" {
  source = "../../modules/rds-postgres"

  identifier         = "${var.name}-source"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "target_kafka" {
  source = "../../modules/msk-kafka"

  cluster_name       = "${var.name}-target"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
}

# The actual CDC wiring: source_server_name is parsed out of source_db's
# endpoint (which comes back as "host:port" — split(":", ...)[0] takes just
# the host, since DMS wants server_name and port as separate arguments).
# target_kafka_broker is target_kafka's bootstrap_brokers_tls output
# directly, connecting DMS to the Kafka cluster this scenario just created.
module "dms" {
  source = "../../modules/dms"

  name               = var.name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  source_server_name   = split(":", module.source_db.endpoint)[0]
  source_database_name = "app"
  source_username      = "dms_reader"
  source_password      = var.source_db_password

  target_engine_name  = "kafka"
  target_kafka_broker = module.target_kafka.bootstrap_brokers_tls
}
