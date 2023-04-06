#data.terraform.s3_block_public.deny

package terraform.s3_block_public

import input.tfplan as tfplan

deny[reason] {
	r = tfplan.resource_changes[_]
	r.mode == "managed"
	r.type == "aws_s3_bucket"
	r.change.after.acl == "public"

	reason := sprintf("%-40s :: S3 buckets must not be PUBLIC", 
	                    [r.address])
}