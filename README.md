# OPA-policy-Terraform-cloud
OPA policy backup specifically for Terraform Cloud. 
## OPA Policy for CIS Guardrails with Terraform Cloud Integration:

### Terraform Plans:

Write your Terraform configurations as you normally would for your infrastructure.
Generate a Terraform plan: terraform plan -out=tfplan
Convert this plan to a JSON format: terraform show -json tfplan > tfplan.json

### OPA Evaluation:

With your OPA policies (in Rego) that enforce the CIS benchmarks, evaluate the JSON Terraform plan: opa eval --input tfplan.json --data your_policy.rego "data.terraform.deny"
If the evaluation returns any denied actions, then the Terraform plan does not adhere to the policies and should not be applied.

### Terraform Cloud:

If the OPA evaluation passes, you can then proceed to apply the plan using Terraform Cloud.
If you're using Terraform Cloud's API, you can automate this process in a CI/CD pipeline.
By following this approach, you'll effectively integrate OPA checks into your Terraform Cloud workflow, ensuring that the configurations you apply adhere to the CIS benchmarks you've encoded in your OPA policies.
