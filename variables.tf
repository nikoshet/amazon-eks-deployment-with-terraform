variable "region" {
    default = "eu-central-1"
    description = "AWS region"
    type = string
}

variable "cluster_name" {
    default = "eks-cluster"
    type = string
}

variable "node_group_instance_types" {
    default = ["t2.medium"]
    type = list(string)
}


variable "aws_auth_accounts" {
    description = "Additional AWS account numbers to add to the aws-auth configmap"
    type = list(string)

    default = [
        "777777777777",
        "888888888888",
    ]
}

variable "aws_auth_roles" {
    description = "Additional IAM roles to add to the aws-auth configmap"
    type = list(object({
        rolearn = string
        username = string
        groups = list(string)
    }))

    default = [
        {
            rolearn  = "arn:aws:iam::66666666666:role/role1"
            username = "role1"
            groups   = ["system:masters"]
        },
    ]
}

variable "aws_auth_users" {
    description = "Additional IAM users to add to the aws-auth configmap"
    type = list(object({
        userarn = string
        username = string
        groups = list(string)
    }))

    default = [
        {
            userarn  = "arn:aws:iam::66666666666:user/user1"
            username = "user1"
            groups   = ["system:masters"]
        },
        {
            userarn  = "arn:aws:iam::66666666666:user/user2"
            username = "user2"
            groups   = ["system:masters"]
        },
    ]
}
