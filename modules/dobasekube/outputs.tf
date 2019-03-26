output "k8s_host" {
  value = "${digitalocean_kubernetes_cluster.cluster.endpoint}"
}

output "k8s_client_certificate" {
  value     = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.client_certificate)}"
  sensitive = true
}

output "k8s_client_key" {
  value     = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.client_key)}"
  sensitive = true
}

output "k8s_cluster_ca_certificate" {
  value     = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)}"
  sensitive = true
}
