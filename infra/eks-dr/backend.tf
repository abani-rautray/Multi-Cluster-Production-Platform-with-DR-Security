terraform {
  backend "s3" {
    bucket         = "multi-cluster-tf-state"
    key            = "eks-dr/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
