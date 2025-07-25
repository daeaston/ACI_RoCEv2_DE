terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
    }
  }
}

provider "aci" {
  alias    = "apic1"
  username = "admin"
  password = "C1sco12345"
  url      = "https://198.18.133.200"
}

provider "aci" {
  alias    = "apic2"
  username = "admin"
  password = "C1sco12345"
  url      = "https://198.18.132.200"
}

module "apic1_qos" {
  source  = "netascode/nac-aci/aci"
  version = "1.0.1"

  providers = {
    aci = aci.apic1
  }

  yaml_directories = ["data"]

  manage_access_policies    = true
  manage_fabric_policies    = false
  manage_pod_policies       = false
  manage_node_policies      = false
  manage_interface_policies = false
  manage_tenants            = false
}

module "apic2_qos" {
  source  = "netascode/nac-aci/aci"
  version = "1.0.1"

  providers = {
    aci = aci.apic2
  }

  yaml_directories = ["data"]

  manage_access_policies    = true
  manage_fabric_policies    = false
  manage_pod_policies       = false
  manage_node_policies      = false
  manage_interface_policies = false
  manage_tenants            = false
}


resource "null_resource" "reset_qos_apic1a" {
  provisioner "local-exec" {
    when    = destroy
    command = "bash ${path.root}/scripts/reset_qos.sh https://apic1-a.corp.pseudoco.com"
  }
}

resource "null_resource" "reset_qos_apic1b" {
  provisioner "local-exec" {
    when    = destroy
    command = "bash ${path.root}/scripts/reset_qos.sh https://apic1-b.corp.pseudoco.com"
  }
}

