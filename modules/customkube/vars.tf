variable "k8s_host" {
  description = "The kubernetes master host endpoint"
}

variable "k8s_client_certificate" {
  description = "client cert for TLS auth"
}

variable "k8s_client_key" {
  description = "client cert key for TLS auth"
}

variable "k8s_cluster_ca_certificate" {
  description = "cert bundle for TLS auth"
}
