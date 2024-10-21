variable "users" {
  type = map(list(string))
  default = {
    ryanemcdaniel            = ["admin", "admin"]
    mergers-and-acquisitions = ["admin", "admin"]
    "Pi515-IA"               = ["admin", "admin"]
    Skarmm                   = ["member", "instructors"]
    eshaz                    = ["member", "instructors"]
    ptlizbeth                = ["member", "instructors"]
    mmorth                   = ["member", "instructors"]
    jayeon                   = ["member", "instructors"]
    "aswen2000"              = ["member", "instructors"]
    troyf                    = ["member", "instructors"]
    mcbullisisu              = ["member", "instructors"]
    jmforde                  = ["member", "instructors"]
    "BrianTran9832"          = ["member", "instructors"]
    chanmoha                 = ["member", "instructors"]
    genepaul                 = ["member", "instructors"]
    zkaramanlis              = ["member", "instructors"]
    ryanhaticus              = ["member", "instructors"]
    clucht100                = ["member", "instructors"]
    maulikshroff             = ["member", "instructors"]
    iadailey                 = ["member", "instructors"]
    SathyaPoliah             = ["member", "instructors"]
    leahhaugh                = ["member", "instructors"]
    guppy57                  = ["member", "instructors"]
    "Enigmatic-Star"         = ["member", "previous-instructors"]
    boergerj                 = ["member", "previous-instructors"]
    spurgear                 = ["member", "previous-instructors"]
    bebitzko                 = ["member", "previous-instructors"]
  }
}

data "github_user" "members" {
  for_each = var.users
  username = each.key
}

resource "github_membership" "members" {
  for_each             = var.users
  username             = each.key
  role                 = each.value[0]
  downgrade_on_destroy = true
}
