package main

# Org convention reminder (warn — does not block CI): flag common resource
# types that don't carry a Project tag. This is intentionally a warning, not
# a deny: this repo's modules default `tags = {}` and the point of this
# policy is to nudge live/<project> stacks toward setting real tags once
# they're not just a scaffolding smoke test, not to block the scaffold itself.

taggable_types := {
	"aws_vpc",
	"aws_s3_bucket",
	"aws_db_instance",
	"aws_ecs_cluster",
	"aws_eks_cluster",
	"aws_lambda_function",
	"aws_dynamodb_table",
}

warn contains msg if {
	rc := input.resource_changes[_]
	taggable_types[rc.type]
	rc.change.after != null
	tags := object.get(rc.change.after, "tags", {})
	not tags.Project
	msg := sprintf("%s has no Project tag (org convention — fine for scaffolding, set one before production)", [rc.address])
}
