#data.test.restrict_region.deny

package test.restrict_region

resource_type = "region"

approved_region = {
  #"us-east-1",
  #"us-east-2",
  #"us-west-1",
  "us-west-2"
  
}

deny[msg] {
  not approved_region[input.region]
  msg = sprintf("%s is not an approved region", [input.region])
}