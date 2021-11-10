output "tenantName" {
  value = var.tenantName
}

output "bdName" {
  value = aci_bridge_domain.basicTenantBd.id
}

output "epgNameWeb" {
  value = aci_application_epg.basicTenantEpgWeb.id
}

output "epgNameDb" {
  value = aci_application_epg.basicTenantEpgDb.id
}