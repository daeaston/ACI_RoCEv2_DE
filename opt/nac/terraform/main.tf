terraform {
  required_providers {
    aci = {
      source  = "ciscodevnet/aci"
      version = "~> 2.16.0"
    }
  }
}

provider "aci" {
  alias    = "apic1-a"
  username = var.admin_username
  password = var.admin_password
  url      = "https://apic1-a.corp.pseudoco.com"
  insecure = true
}

provider "aci" {
  alias    = "apic1-b"
  username = var.admin_username
  password = var.admin_password
  url      = "https://apic1-b.corp.pseudoco.com"
  insecure = true
}

module "qos_apic1_a" {
  source    = "./modules/rocev2_qos"
  providers = { aci = aci.apic1-a }

  admin_username = var.admin_username
  admin_password = var.admin_password
  apic_url       = "https://apic1-a.corp.pseudoco.com"
  cos            = var.cos
}

module "qos_apic1_b" {
  source    = "./modules/rocev2_qos"
  providers = { aci = aci.apic1-b }

  admin_username = var.admin_username
  admin_password = var.admin_password
  apic_url       = "https://apic1-b.corp.pseudoco.com"
  cos            = var.cos
}