locals {
    app = "terragrunt"
    env = "dev"
    aws_profile = "default"
    aws_account = "873827770697"
    az_count = 2
    aws_region = "eu-central-1"
    image_version = "latest"

}

inputs = {
    app = local.app
    env = local.env
    aws_profile = local.aws_profile
    aws_account = local.aws_account
    aws_region = local.aws_region
    image_version = local.image_version
    az_count = local.az_count
}

remote_state {
    backend = "s3" 
    config = {
    bucket = "danil-ignatushkin-project"
    key =  format("%s/terraform.tfstate", path_relative_to_include())
    region = "eu-central-1"
  }
}