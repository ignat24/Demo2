# Demo2
<h1 align="center">Infrastructure as a code</h1>
<h3><b>Objective:</b> using terraform and terragrunt create CI/CD infrastructure on AWS</h3>
<hr>
<h1>About project</h1>

- Video presentation on [YouTube](https://youtu.be/44yNo4tiB7E)

- <h3><b>Tools:</b></h3>

    - Terraform
    - Terragrant
    - AWS
    - Docker

<img align="middle" src="https://www.digiseller.ru/preview/749315/p1_3095929_6f6ca7f8.png" width="250" height="200">    <img align="middle" src="https://s.dou.ua/CACHE/images/img/announces/og-image-8b3e4f7d/8044baf16ab50f3584c67fbb3c52b09a.jpg" width="250" height="200">       <img align="middle" src="https://i1.wp.com/dotsandbrackets.com/wp-content/uploads/2016/09/docker.jpg?fit=524%2C447&ssl=1" width="250" height="200">


<hr>
<h1>Files structure:</h1>

 - app
    - Dockerfile index.html, style.css

- modules
    - /cluster - create ECS, ALB, IAM
    - /network - create VPC, Subnets
    - /ecr - create ECR repository
    - /init-build - create first build application
    - /codebuild - create AWS resourse Codebuild with webhook
- providers
    - /dev - create modules structure for terragrunt in environment "Development"
        - terragrunt.hcl - main terragrunt file
        - buildspec.yml - file which contain build configuration for Codebuild
    - /prod - create modules structure for terragrunt in environment "Production"
        - terragrunt.hcl - main terragrunt file
        - buildspec.yml - file which contain build configuration for Codebuild
        