provider "kubernetes" {
  host                   = "${var.k8s_host}"
  client_certificate     = "${var.k8s_client_certificate}"
  client_key             = "${var.k8s_client_key}"
  cluster_ca_certificate = "${var.k8s_cluster_ca_certificate}"
}

resource "kubernetes_service_account" "gitlab" {
  metadata {
    name      = "gitlab"
    namespace = "default"

    # namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "gitlab-cluster-admin" {
  metadata {
    name = "gitlab-cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "gitlab"
    namespace = "default"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
}
