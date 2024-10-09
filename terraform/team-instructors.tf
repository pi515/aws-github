resource "github_team" "instructors" {
  name    = "instructors"
  privacy = "closed"
}

resource "github_team_settings" "instructors" {
  team_id = github_team.instructors.id
}

resource "github_team_repository" "instructors" {
  for_each   = element(github_repository.public[*], 0)
  team_id    = github_team.instructors.id
  repository = each.value.name
  permission = "push"
}

resource "github_team_membership" "instructors_maintainer" {
  for_each = { for k, v in var.users : k => v if element(v, 1) == "admin" }
  team_id  = github_team.instructors.id
  username = each.key
  role     = "maintainer"
}

resource "github_team_membership" "instructors_member" {
  for_each = { for k, v in var.users : k => v if element(v, 1) == "instructors" }
  team_id  = github_team.instructors.id
  username = each.key
  role     = "member"
}
