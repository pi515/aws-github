resource "github_team" "previous_instructors" {
  name    = "previous-instructors"
  privacy = "closed"
}

resource "github_team_membership" "previous_instructors_members" {
  for_each = { for k, v in var.users : k => v if element(v, 1) == "previous-instructors" }
  team_id  = github_team.students.id
  username = each.key
  role     = "member"
}
