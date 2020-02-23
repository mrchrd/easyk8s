data "template_file" "kubeconfig" {
  template = file("${path.module}/assets/kubeconfig.yaml")

  vars = {
    aws_region                         = local.aws_region
    cluster_certificate_authority_data = aws_eks_cluster.main.certificate_authority[0].data
    cluster_name                       = aws_eks_cluster.main.name
    cluster_server                     = aws_eks_cluster.main.endpoint
  }
}

output "kubeconfig" {
  value = data.template_file.kubeconfig.rendered
}
