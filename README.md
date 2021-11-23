# Demo2
<h1 align="center">Infrastructure as a code</h1>
<h3><b>Objective:</b> using terraform and terragrunt create CI/CD infrastructure on AWS</h3>
<hr>
<h1>About project</h1>
Video presentation on [YouTube]:https://youtu.be/44yNo4tiB7E
<h3><b>Tools:</b></h3>
    - Terraform
    - Terragrant
    - AWS
    - Docker

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
