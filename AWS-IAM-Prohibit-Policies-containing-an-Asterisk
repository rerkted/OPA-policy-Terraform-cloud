                                                                                                                                                                 package tfplan

import "tfplan/v2" as tfplan

# Helper function to check if a resource type is one of the given types
resource_type_in(resource, types) {
    type := resource.change.after.type
    type_name := lower(type)
    type_name == types[_]
}

# Check if a policy statement contains an asterisk in either the action or resource field
contains_asterisk(policy) {
    stmt := policy[_]
    contains(stmt.actions[_], "*") # Check for asterisk in actions
} {
    stmt := policy[_]
    contains(stmt.resources[_], "*") # Check for asterisk in resources
}

# Check for IAM policies containing an asterisk
deny_iam_policies_with_asterisk[msg] {
    iam_resource_types := [
        "aws_iam_policy",
        "aws_iam_role_policy",
    ]
    resource := tfplan.resource_changes[_]
    resource_type_in(resource, iam_resource_types)

    policy_document := resource.change.after["policy"]
    policy := json.unmarshal(policy_document)
    contains_asterisk(policy.statements)

    msg := sprintf("Resource '%s' has an IAM policy containing an asterisk (*) in the action or resource field. Please avoid overly permissive policies.", [resource.change.after.name])
}

# Main rule to collect all the denied messages
deny[msg] {
    msg := deny_iam_policies_with_asterisk[_]
}
