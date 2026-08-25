package main

# Hard guardrail (deny — blocks CI): no S3 bucket should ever plan with
# public access allowed. This should never actually trigger given the
# s3-bucket module always sets all four flags to true, but it's here as a
# backstop in case a future scenario declares a raw aws_s3_bucket_public_access_block
# directly and gets it wrong.

public_access_fields := [
	"block_public_acls",
	"block_public_policy",
	"ignore_public_acls",
	"restrict_public_buckets",
]

deny contains msg if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket_public_access_block"
	after := rc.change.after
	field := public_access_fields[_]
	after[field] == false
	msg := sprintf("%s must have %s = true (no public S3 buckets allowed)", [rc.address, field])
}
