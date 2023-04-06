#data.terraform.public_ingress.deny
package terraform.public_ingress

import input.plan as plan

deny[msg] {
  r := plan.resource_changes[_]
  r.type == "aws_security_group"
  r.change.after.ingress[_].cidr_blocks[_] == "0.0.0.0/0"
  msg := sprintf("%v has 0.0.0.0/0 as allowed ingress", [r.address])
}