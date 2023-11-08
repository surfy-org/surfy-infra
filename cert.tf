resource "aws_acm_certificate" "cert" {
  #max 50 certificates
  domain_name       = "kingos.fr"
  subject_alternative_names = [
    "www.kingos.fr",
  ]
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "production-certificate"
    Environment = "production"
  }
}