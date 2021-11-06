# Demo2
Objective: using terraform and terragrunt create infrastructure on AWS

- modules
 - /cluster - create ECS, ALB, IAM
 - /network - create VPC, Subnets
- providers
    - /dev - create modules structure for terragrunt in environment "Development"
    - /prod - now empty
