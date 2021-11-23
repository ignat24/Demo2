# Demo2
Objective: using terraform and terragrunt create infrastructure on AWS
Video presentation: https://youtu.be/44yNo4tiB7E
- app
    - Dockerfile, index.html, style.css

- modules
    - /cluster - create ECS, ALB, IAM
    - /network - create VPC, Subnets
    - /ecr -  
- providers
    - /dev - create modules structure for terragrunt in environment "Development"
    - /prod - now empty
