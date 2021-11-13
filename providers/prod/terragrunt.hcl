locals {
    app = "terragrunt"
    env = "prod"
    aws_profile = "default"
    aws_account = "873827770697"
    aws_region = "eu-west-2"
    image_version = "0.2"

}

inputs = {
    app = local.app
    env = local.env
    aws_profile = local.aws_profile
    aws_account = local.aws_account
    aws_region = local.aws_region
    image_version = local.image_version
}

remote_state {
    backend = "s3" 
    config = {
        encrypt = true
        bucket = "s3-${local.app}-${local.env}"
        key =  format("%s/terraform.tfstate", path_relative_to_include())
        region = local.aws_region
  }
}