module "vpc" {
    source                  = "terraform-aws-modules/vpc/aws"
    version                 = "3.14.0"
    name                    = "test-vpc"
    cidr                    = "10.0.0.0/16"

    azs                     = data.aws_availability_zones.available.names
    private_subnets         = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    public_subnets          = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

    enable_nat_gateway      = true
    enable_vpn_gateway      = true
    enable_dns_hostnames    = true

    public_subnet_tags = {
        "kubernetes.io/cluster/${var.cluster_name}" = "shared"
        "kubernetes.io/role/elb" = "1"
    }
    private_subnet_tags = {
        "kubernetes.io/cluster/${var.cluster_name}" = "shared"
        "kubernetes.io/role/internal-elb" = "1"
    }    
}


resource "aws_security_group" "node_group_sg" {
    name = "node_group_sg"
    vpc_id = module.vpc.vpc_id

    ingress { 
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [
            #"0.0.0.0/0"#,
            "10.0.0.0/8",
            "172.16.0.0/12",
            "192.168.0.0/16"
        ]
    }
}

resource "aws_security_group" "cluster_sg" {
    name = "cluster_sg"
    vpc_id = module.vpc.vpc_id

    ingress { 
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [
          #"0.0.0.0/0" #
          "10.0.0.0/8"
        ]
    }
}

