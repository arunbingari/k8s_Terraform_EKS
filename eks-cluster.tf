provider "kubernetes" {

  host = data.aws_eks_cluster.ourapp-cluster.endpoint
  cluster_ca_certificate = base64encode( data.aws_eks_cluster.ourapp-cluster.certificate_authority.0.data)
  token = data.aws_eks_cluster_auth.ourapp-cluster.token
}
data "aws_eks_cluster" "ourapp-cluster" {
    name = module.eks.cluster_id
  
}

data "aws_eks_cluster_auth" "ourapp-cluster" {
  name = module.eks.cluster_id
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.5.1"

  cluster_name = "ourapp-eks-cluster"
  cluster_version = "1.21"

  subnet_ids = module.our-app-vpc.private_subnets
    vpc_id = module.our-app-vpc.vpc_id

  tags = {
    environment = "dev"
    application = "ourapp"

  }
   eks_managed_node_groups = {
    dev = {
      min_size     = 1
      max_size     = 3
      desired_size = 3

      instance_types = ["t2.micro"]
    }

}
}