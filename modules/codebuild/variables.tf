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
  default = "buildspec.yml"
}

variable "buildspec_path" {
  
}

variable "github_token" {
  default = "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"
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