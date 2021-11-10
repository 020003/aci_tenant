

provider "aci" {
  username = var.aciUsername
  password = var.aciPassword
  url      = var.aciUrl
  insecure = true
}


#
#

#### Create Tenants
resource "aci_tenant" "basicTenants" {
  name        = var.tenantName
  description = "Terraform Cloud Tenant"

}


resource "aci_application_profile" "ap" {
  tenant_dn   = aci_tenant.basicTenants.id
  name        = "${var.tenantName}_AP"
  description = "This app profile is created by terraform"
}

resource "aci_vrf" "basicTenantVrf" {
  tenant_dn              = aci_tenant.basicTenants.id
  name                   = "${var.tenantName}_VRF"
  bd_enforced_enable     = "no"
  ip_data_plane_learning = "enabled"
  knw_mcast_act          = "permit"
  pc_enf_dir             = "egress"
  pc_enf_pref            = "enforced"
}


resource "aci_bridge_domain" "basicTenantBd" {
  tenant_dn          = aci_tenant.basicTenants.id
  name               = "${var.tenantName}_BD"
  relation_fv_rs_ctx = aci_vrf.basicTenantVrf.id
}

resource "aci_application_epg" "basicTenantEpgWeb" {
  application_profile_dn = aci_application_profile.ap.id
  name                   = "web_EPG"
  relation_fv_rs_bd      = aci_bridge_domain.basicTenantBd.id
}

resource "aci_application_epg" "basicTenantEpgDb" {
  application_profile_dn = aci_application_profile.ap.id
  name                   = "db_EPG"
  relation_fv_rs_bd      = aci_bridge_domain.basicTenantBd.id
}

#

resource "aci_bridge_domain" "basicTenantBd1" {
  tenant_dn                   = aci_tenant.basicTenants.id
  name                        = "NEW_BD"
  relation_fv_rs_ctx          = aci_vrf.basicTenantVrf.id
}

resource "aci_application_epg" "basicTenantEpgWeb2" {
 application_profile_dn    = aci_application_profile.ap.id
 name                      = "new_EPG"
 relation_fv_rs_bd         = aci_bridge_domain.basicTenantBd.id
}
#