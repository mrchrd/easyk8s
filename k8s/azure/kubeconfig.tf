output "kubeconfig" {
  value = azurerm_kubernetes_cluster.main.kube_config_raw
}
