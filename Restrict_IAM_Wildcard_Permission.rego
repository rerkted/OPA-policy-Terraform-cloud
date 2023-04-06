#data.terraform.restrict_iam_permission.rule

package terraform.restrict_iam_permission

import input as tfplan

deny {
	some i
	statement := input.Statement[i]
	statement.Effect == "Allow"
	statement.Resource == "*"
	statement.Action == "*"
  }

rule[msg] {
	some i
	statement := input.Statement[i]
	statement.Effect == "Allow"
	statement.Resource == "*"
	statement.Action == "*"
	
    msg := sprintf("allows full IAM access with %v ", [statement]
    )
}