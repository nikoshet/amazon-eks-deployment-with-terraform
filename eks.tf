
module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 18.21.0"
    cluster_name    = var.cluster_name
    cluster_version = "1.21"

    subnet_ids = module.vpc.private_subnets
    
    cluster_endpoint_private_access = true
    vpc_id = module.vpc.vpc_id

    manage_aws_auth_configmap = true # Determines whether to manage the aws-auth configmap

    eks_managed_node_groups = {
      eks_nodes = {
        name                                    = "managed-node-group-1"
        instance_types                          =  var.node_group_instance_types #default: ["t3.medium"]
        user_data                               = "echo foo bar" #additional_userdata
        #node_security_group_id                  = aws_security_group.node_group_sg.id
        capacity_type                           = "ON_DEMAND"
        #scaling_config = {
        min_size                              = 1
        max_size                              = 1
        desired_size                          = 1
        #}
      }
    }

    cluster_additional_security_group_ids        = [aws_security_group.cluster_sg.id]
    aws_auth_roles                               = var.aws_auth_roles
    aws_auth_users                               = var.aws_auth_users
    aws_auth_accounts                            = var.aws_auth_accounts

}
