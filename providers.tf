provider "aws" {
    region = var.region
}

provider "kubernetes" {
    host = data.aws_eks_cluster.my_cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.my_cluster.certificate_authority.0.data)
    token = data.aws_eks_cluster_auth.my_cluster.token
    #load_config_file = false
    config_path    = "~/.kube/config"

    # exec {
    #   api_version = "client.authentication.k8s.io/v1alpha1"
    #   command     = "aws"
    #   # This requires the awscli to be installed locally where Terraform is executed
    #   args = ["eks", "get-token", "--cluster-name", module.eks.cluster_id]
    # }

}