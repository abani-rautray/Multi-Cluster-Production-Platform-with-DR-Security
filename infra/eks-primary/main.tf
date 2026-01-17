locals {
  tags = {
    Environment = var.environment
    Project     = "multi-cluster-platform"
    ManagedBy   = "terraform"
  }
}

module "vpc" {
  source = "../modules/vpc"

  name = "primary-vpc"
  cidr = "10.0.0.0/16"

  azs = ["ap-south-1a", "ap-south-1b"]

  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

  tags = local.tags
}

module "eks" {
  source = "../modules/eks"

  cluster_name    = "prod-primary"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets

  tags = local.tags
}

module "argocd_irsa" {
  source = "../modules/iam"

  role_name                 = "argocd-irsa"
  oidc_provider_arn         = module.eks.oidc_provider_arn
  namespace_service_accounts = ["argocd:argocd-server"]

  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  ]

  tags = local.tags
}


module "karpenter" {
  source       = "../modules/karpenter"
  cluster_name = module.eks.cluster_name
  tags         = local.tags
}
