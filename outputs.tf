output "cluster_endpoint" {
    description = "Endpoint for EKS control plane"
    value = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
    description = "Security groyp ids attached to the cluster control plane"
    value = module.eks.cluster_security_group_id
}

output "kubernetes_version_in_eks_cluster" {
    description = " The Kubernetes server version for the cluster"
    value = data.aws_eks_cluster.my_cluster.version
}

output "eks_cluster_status" {
    description = " The status of the EKS cluster"
    value = data.aws_eks_cluster.my_cluster.status
}

output "config_map_aws_auth" {
    description = "A Kubernetes configuration to authenticate to this EKS cluster"
    value = module.eks.aws_auth_configmap_yaml 
}

output "region" {
    description = "AWS region"
    value = var.region
}

output "load_balancer_hostname" {
  value = kubernetes_service.webserver_service.status.0.load_balancer.0.ingress.0.hostname
}