data "aws_region" "current" {}

variable "aws_region" {
  
}

variable "app" {
  
}

variable "env" {
  
}

variable "ecr_repository_url" {
  
}

variable "vpc_id" {
  
}

variable "cidr_blocks"{
    default = "0.0.0.0/0"
}

variable "buildspec_file" {
  default = "providers/dev/buildspec.yml"
}

variable "github_token" {
  default = "***********************************"
}




variable "private_subnet_ids" {
  type = set(string)
}

variable "pattern_branch" {
  default = "^refs/heads"
}

variable "branch_githook" {
  description = "Variable for pattern that show what branch codebuild will be wait"
  default = "main"
}

variable "git_event" {
  default = "PUSH"
}

variable "repository_url" {
  default = "https://github.com/ignat24/Demo2.git"
}