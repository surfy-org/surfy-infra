resource "aws_ecr_repository" "surfy_frontend" {
    name  = "surfy-frontend"
    tags = {
        Name = "Front-end ECR repository"
    }
}