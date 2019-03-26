variable "cluster_name" {
  description = "Name of the kubernetes cluster that will be created"
}

variable "k8s_version" {
  description = "Version of kubernetes to deploy"
  default     = "1.13.4-do.0"
}

variable "node_size" {
  description = "The droplet size to create"
  default     = "s-2vcpu-2gb"
}

variable "cluster_size" {
  description = "The number of kubernetes worker nodes to deploy"
  default     = 2
}

variable "do_zone" {
  description = "The digital ocean zone to deploy to"
  default     = "nyc1"
}

variable "traefik_replicas" {
  description = "the number of traefik ingress replicas to run"
  default     = 2
}

variable "do_token" {
  description = "The digitalocean access token secret"
}

variable "lets_encrypt_email" {
  description = "The email address to use when creating certificates iwth let's encrypt"
}

variable "lets_encrypt_main_domain" {
  description = "The domain to register as the main domain when creating the certificate.  *.$DOMAIN will be the main, it will also register $DOMAIN"
}
