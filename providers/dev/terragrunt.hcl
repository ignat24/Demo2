locals {
    app = "terragrunt"
    env = "dev"
    aws_profile = "default"
    aws_account = "873827770697"
    aws_region = "eu-central-1"

}

inputs = {
    app = local.app
    env = local.env
    aws_profile = local.aws_profile
    aws_account = local.aws_account
    aws_region = local.aws_region
}

remote_state {
    backend = "s3" 
    config = {
    bucket = "danil-ignatushkin-project"
    key =  format("%s/terraform.tfstate", path_relative_to_include())
    region = "eu-central-1"
  }
}