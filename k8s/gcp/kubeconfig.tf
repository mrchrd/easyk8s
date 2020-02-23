data "template_file" "kubeconfig" {
  template = file("${path.module}/assets/kubeconfig.yaml")

  vars = {
    cluster_certificate_authority_data = google_container_cluster.main.master_auth[0].cluster_ca_certificate
    cluster_name                       = google_container_cluster.main.name
    cluster_server                     = "https://${google_container_cluster.main.endpoint}"
  }
}

output "kubeconfig" {
  value = data.template_file.kubeconfig.rendered
}
