#data.terraform.limit_ec2.deny

package terraform.limit_ec2

import input.tfplan as tfplan

# deny if it creates more than 5 EC2 instances
deny[msg] {                             
    instances := [res | res:=input.Resources[_]; res.Type == "AWS::EC2::Instance"]   
    count(instances) > 5
    msg := sprintf("more than %d ec2 are being deployed", [instances])
  	
}