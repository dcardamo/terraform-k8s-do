resource "digitalocean_kubernetes_cluster" "cluster" {
  name    = "${var.cluster_name}"
  region  = "${var.do_zone}"
  version = "${var.k8s_version}"

  node_pool {
    name       = "default"
    size       = "${var.node_size}"
    node_count = "${var.node_count}"
  }
}

provider "kubernetes" {
  host                   = "${digitalocean_kubernetes_cluster.cluster.endpoint}"
  client_certificate     = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)}"
}

resource "local_file" "kubeconfig" {
  content  = "${digitalocean_kubernetes_cluster.cluster.kube_config.0.raw_config}"
  filename = "kubeconfig.yaml"
}

resource "kubernetes_service_account" "tiller" {
  automount_service_account_token = true

  metadata {
    name      = "tiller-service-account"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "tiller" {
  metadata {
    name = "tiller-cluster-rule"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "${kubernetes_service_account.tiller.metadata.0.name}"
    api_group = ""
    namespace = "${kubernetes_service_account.tiller.metadata.0.namespace}"
  }
}

provider "helm" {
  install_tiller  = true
  service_account = "${kubernetes_service_account.tiller.metadata.0.name}"
  namespace       = "kube-system"

  kubernetes {
    host                   = "${digitalocean_kubernetes_cluster.cluster.endpoint}"
    client_certificate     = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.client_certificate)}"
    client_key             = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.client_key)}"
    cluster_ca_certificate = "${base64decode(digitalocean_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)}"
  }
}

data "template_file" "traefik_values" {
  template = "${file("${path.module}/templates/traefik_values.yml")}"

  vars {
    lets_encrypt_main_domain = "${var.lets_encrypt_main_domain}"
    lets_encrypt_email       = "${var.lets_encrypt_email}"
  }
}

resource "helm_release" "traefik" {
  name  = "traefik-ingress"
  chart = "stable/traefik"

  values = [
    "${data.template_file.traefik_values.rendered}",
  ]

  set_sensitive {
    name  = "acme.dnsProvider.digitalocean.DO_AUTH_TOKEN"
    value = "${var.do_token}"
  }
}

resource "helm_release" "dashboard" {
  name      = "kubernetes-dashboard"
  chart     = "stable/kubernetes-dashboard"
  namespace = "kube-system"

  set {
    name  = "rbac.create"
    value = true
  }
}
