resource "aws_ecr_repository" "surfy_frontend" {
    name  = "surfy-frontend"
    force_delete = true
    tags = {
        Name = "Front-end ECR repository"
    }
}