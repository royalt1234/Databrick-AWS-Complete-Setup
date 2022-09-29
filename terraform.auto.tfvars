### Create databricks workspace ###
databricks_account_username = ""
databricks_account_password = ""
databricks_account_id       = ""

#### LT/ALB/ASG ###
region               = "us-east-1"
desired_capacity     = 1
max_size             = 3
min_size             = 1
availability_zones   = "us-east-1a"
vpc_id               = ""
name_prefix          = ""
image_id             = ""
instance_type        = "o"
volume_size          = 10
iam_instance_profile = ""
key_name             = ""
domain_name          = ""
private_zone         = ""
sub_domain           = ""
lb_name              = ""
lb-tg-name           = ""
asg_name             = ""


# #### manage databricks workspace #####
# host                            = ""
# token                           = ""
# cluster_name                    = ""
# cluster_name-1                  = ""
# num_workers                     = 1
# num_workers_task-1              = 1
# cluster_autotermination_minutes = 60
# cluster_num_workers             = 1
# notebook_subdirectory           = "Terraform"
# notebook_filename               = "notebook-getting-started-quick-start.sql"
# notebook_language               = "SQL"
# git_username                    = ""
# git_provider                    = "gitHub"
# personal_access_token           = ""
# repo_url                        = ""
# job_name                        = ""
# pipeline_name                   = ""
# multiple_job_name               = ""