# Terraform-Kubernetes-DigitalOcean

This project will allow you to automate creating a [kubernetes](https://kubernetes.io) cluster on
[DigitalOcean](https://digitalocean.com) using [terraform](https://terraform.io) to automate that.  The cluster will
have the following features:
* Pick your cluster size, node size, region
* Choose your version of kubernetes provided DigitalOcean supports it
* Helm installed
* Traefik installed as the ingress service
  * DigitalOcean load balancer in front of the redundant Traefik services
  * Lets encrypt SSL certs using your domain.   Requires you host your DNS with digitalocean
* Kubernetes Dashboard installed
* Gitlab account created for continuous deployment
* Easy to add more clusters such as staging/testing/etc

## Setup
1.  create a file called `prod/prod.tfvars` with inputs matching `vars.tf`
2.  `terraform init`
3.  `terraform apply -var-file=autobots.tfvars`
4.  `cp kubeconfig.yaml ~/.kube/config`

## More environments

You can setup more environments such as "staging" using this setup.   Copy the prod folder to you new environment name
such as "staging" and then follow the steps in Setup above


## Attribution

This initially comes from this medium post
https://medium.com/@stepanvrany/terraforming-dok8s-helm-and-traefik-included-7ac42b5543dc

