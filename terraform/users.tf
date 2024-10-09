variable "users" {
  type = map(list(string))
  default = {
    ryanemcdaniel = ["admin", "Admin", "maintainer"]
  }
}

data "github_user" "users" {
  for_each = var.users
  username = each.key
}

resource "github_membership" "users" {
  for_each = element(data.github_user.users[*], 0)
  username = each.value.username
  role     = element(var.users[each.key], 0)
}
