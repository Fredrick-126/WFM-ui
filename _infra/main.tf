data "terraform_remote_state" "main" {
  backend = "azurerm"

  config = {
    storage_account_name = "wfm48593"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
    #sas_token            = "?sv=2017-07-29&ss=b&srt=sco&sp=rwdlac&se=2030-09-05T21:26:27Z&st=2020-09-07T21:26:27Z&spr=https&sig=hXJNHlmhbNUQa8iU%2FiLBx7Q%2BumjUNQrN2luPkMCOWmg%3D" moved in ci

  }
  workspace = terraform.workspace
}

locals {
  k8s_recource_name_prefix = "${terraform.workspace}-${data.terraform_remote_state.main.outputs.app_name}"
}
output "kube_cnf_raw" {
  value     = data.terraform_remote_state.main.outputs.kube_cnf_raw
  sensitive = true
}

output "useful_commands" {
  value = <<CONFIGURE
To authenticate kubectl
- To get kubectl context on the cluster for your azure user:
$ az aks get-credentials --resource-group ${data.terraform_remote_state.main.outputs.resource_group_name} --name ${data.terraform_remote_state.main.outputs.kubernetes_cluster_name}
- To have a kubectl configuration:
$ terraform output kube_cnf_raw > kube.conf
$ export KUBECONFIG="kube.conf" (on Windows $env:KUBECONFIG="kube.conf")

CONFIGURE
}
#trigger ci test 12345
