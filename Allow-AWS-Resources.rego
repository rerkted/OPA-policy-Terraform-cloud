#data.terraform.allow_resources.deny

package terraform.allow_resources

import input.plan as plan


# Allowed Terraform resources
allowed_resources = [
	"aws_security_group",
	"aws_instance",
  "aws_subnet",
  "aws_route",
  "aws_route_table",
  "aws_internet_gateway",
  "aws_nat_gateway",
  "aws_vpc",
  "aws_route_table_association",
  "aws_eip",
	"aws_s3_bucket"
]

array_contains(arr, elem) {
	arr[_] = elem
}

deny[reason] {
	resource := plan.resource_changes[_]
	action := resource.change.actions[count(resource.change.actions) - 1]
	array_contains(["create", "update"], action) # allow destroy action

	not array_contains(allowed_resources, resource.type)

	reason := sprintf(
		"%s: resource type %q is not allowed",
		[resource.address, resource.type],
	)
}