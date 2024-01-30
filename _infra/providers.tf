terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.70.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.10.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.41.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }
  }
}
provider "kubernetes" {

  host                   = data.terraform_remote_state.main.outputs.kubernetes_cluster_host
  client_certificate     = data.terraform_remote_state.main.outputs.kubernetes_cluster_client_certificate
  client_key             = data.terraform_remote_state.main.outputs.kubernetes_cluster_client_key
  cluster_ca_certificate = data.terraform_remote_state.main.outputs.kubernetes_cluster_cluster_ca_certificate
}
