locals {
  tags = {
    Environment = var.environment
    Project     = "multi-cluster-platform"
    ManagedBy   = "terraform"
  }
}

module "vpc" {
  source = "../modules/vpc"

  name = "dr-vpc"
  cidr = "10.1.0.0/16"

  azs = ["ap-south-1a", "ap-south-1b"]

  public_subnets  = ["10.1.101.0/24", "10.1.102.0/24"]
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24"]

  tags = local.tags
}

module "eks" {
  source = "../modules/eks"

  cluster_name    = "prod-dr"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets

  tags = local.tags
}

# IRSA for ArgoCD (same as primary)
module "argocd_irsa" {
  source = "../modules/iam"

  role_name                  = "argocd-irsa-dr"
  oidc_provider_arn          = module.eks.oidc_provider_arn
  namespace_service_accounts = ["argocd:argocd-server"]

  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  ]

  tags = local.tags
}

# Karpenter node IAM
module "karpenter" {
  source       = "../modules/karpenter"
  cluster_name = module.eks.cluster_name
  tags         = local.tags
}
