terraform {
    required_version = ">= 0.14.0"

    required_providers {
      aws = {
        version = ">= 4.14.0"
        source  = "hashicorp/aws"
      }
      kubernetes = {
        version = "~> 2.10"
      }
    }
}
