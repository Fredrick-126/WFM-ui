# if state lock cannot be removed, try this:
# $ az storage blob lease break -b "terraform.tfstateenv:dev" -c terraform-state --account-name wfm48593

terraform {
  backend "azurerm" {
    storage_account_name = "wfm48593"
    container_name       = "terraform-state-k8s-apps-ui"
    key                  = "terraform.tfstate"
    #sas_token            = "?sv=2017-07-29&ss=b&srt=sco&sp=rwdlac&se=2030-09-05T21:26:27Z&st=2020-09-07T21:26:27Z&spr=https&sig=hXJNHlmhbNUQa8iU%2FiLBx7Q%2BumjUNQrN2luPkMCOWmg%3D" moved in ci
  }
}
