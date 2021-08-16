resource "local_file" "kubeconfig" {
  depends_on   = [azurerm_kubernetes_cluster.cluster]
  filename     = "kubeconfig"
  content      = azurerm_kubernetes_cluster.cluster.kube_config_raw
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate
}

output "client_key" {
  value = azurerm_kubernetes_cluster.cluster.kube_config.0.client_key
}

output "cluster_ca_certificate" {
    value = azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate
}

output "kubernetes_cluster_endpoint"{
    value = azurerm_kubernetes_cluster.cluster.kube_config.0.host
}