
terraform {
  required_version = ">= 1.16.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "security_lab" {
  name     = "rg-azure-iac-security"
  location = "brazilsouth"

  tags = {
    environment = "lab"
    project     = "Azure-IaC-Security"
    managed_by  = "Terraform"
  }
}


resource "azurerm_network_security_group" "security_nsg" {
  name                = "nsg-security-lab"
  location            = azurerm_resource_group.security_lab.location
  resource_group_name = azurerm_resource_group.security_lab.name

  security_rule {
    name                       = "Allow-SSH-Insecure"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "192.0.2.10/32"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "lab"
    project     = "Azure-IaC-Security"
  }
}


resource "azurerm_storage_account" "secure_storage" {
  name                     = "stiacsecuritylab001"
  resource_group_name      = azurerm_resource_group.security_lab.name
  location                 = azurerm_resource_group.security_lab.location
  account_tier             = "Standard"
  account_replication_type = "ZRS"

  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = false
  public_network_access_enabled   = false

  blob_properties {
    versioning_enabled = true

    delete_retention_policy {
      days = 7
    }

    container_delete_retention_policy {
      days = 7
    }
  }

  tags = {
    environment = "lab"
    project     = "Azure-IaC-Security"
    managed_by  = "Terraform"
  }
}
