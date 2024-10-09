resource "github_team" "admin" {
  name    = "admin"
  privacy = "closed"
}

resource "github_organization_security_manager" "admin" {
  team_slug = github_team.admin.slug
}

resource "github_team_settings" "admin" {
  team_id = github_team.admin.id
}

resource "github_team_repository" "admin" {
  for_each   = element(github_repository.public[*], 0)
  team_id    = github_team.admin.id
  repository = each.value.name
  permission = "admin"
}

resource "github_team_membership" "admin_maintainer" {
  for_each = { for k, v in var.users : k => v if element(v, 1) == "admin" }
  team_id  = github_team.admin.id
  username = each.key
  role     = "maintainer"
}
