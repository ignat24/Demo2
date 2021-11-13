provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {}
}

resource "aws_ecr_repository" "ecr_repository" {
  name = "ecr-${var.app}-${var.env}"
}