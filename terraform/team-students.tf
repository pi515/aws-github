resource "github_team" "students" {
  name    = "students"
  privacy = "closed"
}

resource "github_team_membership" "students_member" {
  for_each = { for k, v in var.users : k => v if element(v, 1) == "students" }
  team_id  = github_team.students.id
  username = each.key
  role     = "member"
}
