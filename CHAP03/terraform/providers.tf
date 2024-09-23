terraform {
  required_version = ">=0.12"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.15.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.116.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.6.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "~>3.4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~>2.5.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "azapi" {
  use_msi = false
}
