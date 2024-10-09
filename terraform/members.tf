variable "users" {
  type = map(list(string))
  default = {
    ryanemcdaniel = ["admin", "admin"]

    "Pi515-IA" = ["member", "instructors"]
    ptlizbeth  = ["member", "instructors"]
    Skarmm     = ["member", "instructors"]
    eshaz      = ["member", "instructors"]
    mmorth     = ["member", "instructors"]
    jayeon     = ["member", "instructors"]

    "aswen2000"     = ["member", "instructors"]
    troyf           = ["member", "instructors"]
    mcbullisisu     = ["member", "instructors"]
    jmforde         = ["member", "instructors"]
    "BrianTran9832" = ["member", "instructors"]
    chanmoha        = ["member", "instructors"]
    genepaul        = ["member", "instructors"]
    zkaramanlis     = ["member", "instructors"]
    ryanhaticus     = ["member", "instructors"]

    "Enigmatic-Star" = ["member", "previous-instructors"]
    boergerj         = ["member", "previous-instructors"]
    spurgear         = ["member", "previous-instructors"]
    bebitzko         = ["member", "previous-instructors"]
  }
}

data "github_user" "members" {
  for_each = var.users
  username = each.key
}

resource "github_membership" "members" {
  for_each             = element(data.github_user.members[*], 0)
  username             = each.value.username
  role                 = each.value[0]
  downgrade_on_destroy = true
}
