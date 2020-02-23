resource "aws_eks_cluster" "main" {
  name     = local.cluster_name
  role_arn = aws_iam_role.main.arn
  version  = local.cluster_version

  vpc_config {
    subnet_ids = data.aws_subnet_ids.default.ids
  }
}

output "cluster_name" {
  value = aws_eks_cluster.main.name
}
