resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  instance_types  = local.instance_types
  node_group_name = local.cluster_name
  node_role_arn   = aws_iam_role.main.arn
  subnet_ids      = data.aws_subnet_ids.default.ids

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }
}
