module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.3"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_irsa = true

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  # Restrict API access to only your current public IP
  cluster_endpoint_public_access_cidrs = ["76.36.21.48/32"]

  # Gives the IAM identity running Terraform (your user adrian) admin in the cluster
  enable_cluster_creator_admin_permissions = true

# (Recommended) Use the modern access-entry auth mode
  authentication_mode = "API_AND_CONFIG_MAP"



  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2
    }
  }

  tags = {
    Project = var.cluster_name
  }

}