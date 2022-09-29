## Databricks
Install and configure the command line tools that Terraform needs to operate. These tools include the [Databricks CLI](https://docs.databricks.com/dev-tools/cli/index.html), the Terraform CLI, and the AWS CLI.

https://docs.databricks.com/dev-tools/ci-cd/ci-cd-jenkins.html#design-the-pipeline

https://docs.databricks.com/repos/set-up-git-integration.html

https://docs.databricks.com/getting-started/introduction/index.html

https://docs.databricks.com/workflows/delta-live-tables/delta-live-tables-ui.html

https://docs.databricks.com/dev-tools/terraform/index.html

https://docs.databricks.com/dev-tools/terraform/e2-workspace.html

https://docs.databricks.com/dev-tools/terraform/workspace-management.html

https://docs.databricks.com/repos/index.html#configure-your-git-integration-with-databricks

https://docs.databricks.com/dev-tools/terraform/cluster-notebook-job.html

https://docs.databricks.com/dev-tools/ci-cd/ci-cd-jenkins.html


## LaunchTemplate/ALB/ASG
The vpc id and subnet id needs to be inputed in the autoscaling module variable. You can eith do this or tag the vpc on the aws account and create a vpc filter block under the data for vpc and reference the tagged vpc there.

All backend resources are commented out. 

Please check the security module to adjust the the egress and ingress as per your infrastructure requirements.

## Note about the Create databricks workspace and manage databricks workspace module
This current module version has not been configured create and output the workspace token yet due to some bugs. The issue is being looked into, should be enabled in the next version of this module.

So for now, at first run, comment out the manage databricks workspace module(this include its section on the `.tfvars` file and `varaiable.tf` file). After the work space is created the you can uncomment them; along side this line in `data.tf`
````
# data "databricks_current_user" "me" {}
```

also this block of code in the `main.tf` :
```
# provider "databricks" {
#   host  = var.host
#   token = var.token
# }
```