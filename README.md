# Deployment on Amazon EKS with Terraform

## About 
This project creates an Elastic Kubernetes (EKS) cluster on AWS and deploys a demo Web Server with its Load Balancer using Terraform.

## Used

| Name | Version
| :---: | :---: 
| [terraform](https://www.terraform.io/cli) | >= 0.14.0 
| [kubectl](https://kubernetes.io/docs/tasks/tools/)  | v1.19.0
| [aws provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) | >= 4.14.0 
| [kubernetes provider](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs) | ~> 2.10
| [kubernetes cluster_version](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest#input_cluster_version) | 1.21
| [eks version](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/18.21.0) |  ~> 18.21.0

## Steps To Follow
* Create a Free Tier Account in AWS 
* Setup an IAM User and its credentials, as well as set permissions and tags (relative link [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html#id_users_create_console))
* Store User, Access Key ID, Secret Access Key, ID locally
* Do updates and install [Terraform](https://www.terraform.io/cli), [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
```
# install Terraform
sudo apt-get update -y && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update -y && sudo apt-get install terraform
# install awscli
sudo apt-get install -y awscli
```
* Set AWS credentials as variables or configure them in ~/.aws/credentials file to login to AWS
```
aws configure
//export AWS_SECRET_ACCESS_KEY="YOUR_ACCESS_KEY"
//export AWS_ACCESS_KEY_ID="YOUR_KEY_ID " 
```
* Download Terraform libraries and initialize the Terraform state for the main application, verify the execution plan and apply infra
```
terraform init

terraform plan
terraform apply
```


## To interact with the cluster
* Download and install [kubectl](https://kubernetes.io/docs/tasks/tools/) 
```
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
```
* Get the EKS configuration file
```
#rm -rf ~/.kube/config
mv ~/.kube/config_temp
aws eks update-kubeconfig --name eks-cluster --region eu-central-1
```
* Now you can interact with the cluster
```
kubectl get nodes
kubectl get deploy
kubectl get svc
```

## To make sure that the Load Balancer and the Web Server are working
```
export lb_url=$(kubectl get svc terraform-example-webserver -o jsonpath='{.status.loadBalancer.ingress[*].hostname}')
# curl -k -s http://${lb_url}
```
(or copy the load_balancer_hostname output and paste it in your browser)

## To clean up
```
terraform destroy
```