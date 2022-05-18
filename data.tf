# Retrieve information about an EKS Cluster
data "aws_eks_cluster" "my_cluster" { 
    name = module.eks.cluster_id
}

# Get an authentication token to communicate with an EKS cluster
data "aws_eks_cluster_auth" "my_cluster" { 
    name = module.eks.cluster_id
}

# The Availability Zones data source allows access to the list 
# of AWS Availability Zones which can be accessed by an AWS 
# account within the region configured in the provider
data "aws_availability_zones" "available" {
}