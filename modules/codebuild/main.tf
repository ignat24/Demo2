provider "aws" {
  region = var.aws_region
}



terraform {
  backend "s3" {}
}

# resource "aws_codebuild_source_credential" "github_token" {
#   auth_type = "PERSONAL_ACCESS_TOKEN"
#   server_type = "GITHUB"
#   token = var.github_token
# }

resource "null_resource" "import_credentials" {
  
  triggers = {
    github_oauth_token = var.github_token
  }

  provisioner "local-exec" {
    command = <<EOF
      aws --region ${data.aws_region.current.name} codebuild import-source-credentials \
                                                             --token ${var.github_token} \
                                                             --server-type GITHUB \
                                                             --auth-type PERSONAL_ACCESS_TOKEN
EOF
  }

}

resource "aws_codebuild_project" "codebuild" {
  depends_on = [null_resource.import_credentials]
  name = "codebuild-${var.app}-${var.env}"
  build_timeout = "60"
  service_role = aws_iam_role.role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/standard:4.0"
    type = "LINUX_CONTAINER"
    privileged_mode = true
    # image_pull_credentials_type = "CODEBUILD"

  environment_variable {
    name = "Stage"
    value = var.env
  }

  }



  source {
    buildspec = var.buildspec_file
    type = "GITHUB"
    location = var.repository_url
    git_clone_depth = 1
    report_build_status = "true"
  }


  vpc_config {
    vpc_id = var.vpc_id
    subnets = var.private_subnet_ids
    security_group_ids = [aws_security_group.sg_codebuild.id]
  }
}

resource "aws_codebuild_webhook" "webhook" {
  project_name = aws_codebuild_project.codebuild.name

  filter_group {
    filter{
        type = "EVENT"
        pattern = var.git_event
    }

    filter {
        type = "HEAD_REF"
        pattern = var.pattern_branch
    }
  }
}