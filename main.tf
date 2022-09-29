provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
  }
}

# provider "databricks" {
#   host  = var.host
#   token = var.token
# }

# resource "aws_s3_bucket" "terraform-state" {
#   bucket = var.bucket_name

# /* Only uncomment the force destroy after you have migrated the state away from the s3 backend. Then you can force destroy the s3 bucket */

#   # force_destroy = true
# }

# resource "aws_s3_bucket_versioning" "bucket-version" {
#   bucket = aws_s3_bucket.terraform-state.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "terraform-state" {
#   bucket = aws_s3_bucket.terraform-state.id
#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }


# resource "aws_dynamodb_table" "backend-state-locks" {
#   name         = var.dynamodb_name
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

module "LaunchTemplate" {
  source               = "./modules/LaunchTemplate"
  region               = var.region
  subnet_id            = data.aws_subnets.subnet.id
  vpc_id               = var.vpc_id
  alpha-template       = module.LaunchTemplate.alpha-template
  name_prefix          = var.name_prefix
  image_id             = var.image_id
  instance_type        = var.instance_type
  volume_size          = var.volume_size
  key_name             = var.key_name
  availability_zones   = var.availability_zones
  aws_lb_target_group  = module.LoadBalancer.aws_lb_target_group
  asg_name             = var.asg_name
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  iam_instance_profile = var.iam_instance_profile
  aws_security_group-1 = module.Security.aws_security_group-1

}

module "LoadBalancer" {
  source              = "./modules/LoadBalancer"
  aws_lb_target_group = module.LoadBalancer.aws_lb_target_group
  vpc_id              = var.vpc_id
  asg_name            = var.asg_name
  domain_name         = var.domain_name
  private_zone        = var.private_zone
  sub_domain          = var.sub_domain
  lb_name             = var.lb_name
  lb-tg-name          = var.lb-tg-name
  desired_capacity    = var.desired_capacity
  alpha-template      = module.LaunchTemplate.alpha-template
  availability_zones  = var.availability_zones
  min_size            = var.min_size
  max_size            = var.max_size
  aws_security_group  = module.Security.aws_security_group
}

module "Security" {
  source               = "./modules/Security"
  iam_instance_profile = var.iam_instance_profile
  vpc_id               = var.vpc_id
  aws_security_group   = module.Security.aws_security_group
}

##### create databricks workspace ####
module "createWS" {
  source                      = "./modules/create-databricks-workspace"
  region                      = var.region
  databricks_account_username = var.databricks_account_username
  databricks_account_password = var.databricks_account_password
  databricks_account_id       = var.databricks_account_id
  vpc_id                      = var.vpc_id
  aws_security_group          = module.Security.aws_security_group
}

##### manage databricks workspace ####
# module "manageWS" {
#   source                          = "./modules/manage-databricks-workspace"
#   host                            = var.host
#   token                           = var.token
#   cluster_name                    = var.cluster_name
#   cluster_name-1                  = var.cluster_name-1
#   cluster_autotermination_minutes = var.cluster_autotermination_minutes
#   num_workers                     = var.num_workers
#   num_workers_task-1              = var.num_workers_task-1
#   git_username                    = var.git_username
#   git_provider                    = var.git_provider
#   personal_access_token           = var.personal_access_token
#   repo_url                        = var.repo_url
#   job_name                        = var.job_name
#   notebook_language               = var.notebook_language
#   notebook_filename               = var.notebook_filename
#   multiple_job_name               = var.multiple_job_name
#   pipeline_name                   = var.pipeline_name
#   path                            = "${data.databricks_current_user.me.home}/${var.notebook_subdirectory}/${var.notebook_filename}"
# }
