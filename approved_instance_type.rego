#data.test.not_approved_instance.deny

package test.not_approved_instance

import input.plan as plan

resource_type = "aws_instance"

not_approved_instances = {
   #"t2.micro",
   #"t2.small",
   #"t2.medium",
   #"t2.large",
   "t2.xlarge",
   "t2.2xlarge"
}

#deny[msg] {
#  not not_approved_instances[input.instance_type]
#  msg = sprintf("%s is not an approved instance type", [input.instance_type])
#}

####
array_contains(arr, elem) {
	arr[_] = elem
}

deny[reason] {
	resource := plan.resource_changes[_]
	action := resource.change.actions[count(resource.change.actions) - 1]
	array_contains(["create", "update"], action) # allow destroy action

	not array_contains(not_approved_instances, resource_type)

	reason := sprintf(
		"%s: resource type %q is not allowed",
		[not_approved_instances, resource_type],
	)
}