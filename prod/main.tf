provider "digitalocean" {
  token = "${var.do_token}"
}

module "dobasekube" {
  source = "../modules/dobasekube"

  do_token                 = "${var.do_token}"
  cluster_name             = "${var.cluster_name}"
  do_zone                  = "${var.do_zone}"
  k8s_version              = "${var.k8s_version}"
  node_size                = "${var.node_size}"
  node_count               = "${var.cluster_size}"
  lets_encrypt_main_domain = "${var.lets_encrypt_main_domain}"
  lets_encrypt_email       = "${var.lets_encrypt_email}"
}

module "customkube" {
  source = "../modules/customkube"

  k8s_host                   = "${module.dobasekube.k8s_host}"
  k8s_client_certificate     = "${module.dobasekube.k8s_client_certificate}"
  k8s_client_key             = "${module.dobasekube.k8s_client_key}"
  k8s_cluster_ca_certificate = "${module.dobasekube.k8s_cluster_ca_certificate}"
}
