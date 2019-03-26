# Terraform-Kubernetes-DigitalOcean

This project will allow you to automate creating a
[kubernetes](https://kubernetes.io) cluster on
[DigitalOcean](https://digitalocean.com) using [terraform](https://terraform.io)
to automate that.  The cluster will have the following features:
* 

## Setup
1.  create a file called `autobots.tfvars` with inputs matching `vars.tf`
2.  `terraform init`
3.  `terraform apply -var-file=autobots.tfvars`
4.  `cp kubeconfig.yaml ~/.kube/config`
5.  `make encrypt`


## Attribution

This initially comes from this medium post
https://medium.com/@stepanvrany/terraforming-dok8s-helm-and-traefik-included-7ac42b5543dc

