#
# GH Team - Admin
#
resource "github_team" "admin" {
  name    = "Admin"
  privacy = "public"
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
  team_id  = github_team.admin.id
  username = data.github_user.users["ryanemcdaniel"].username
  role     = "maintainer"
}


#
# GH Team - Instructors
#
resource "github_team" "instructors" {
  name    = "Instructors"
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
  team_id  = github_team.instructors.id
  username = data.github_user.users["ryanemcdaniel"].username
  role     = "maintainer"
}

resource "github_team_membership" "instructors_member" {
  for_each = { for k, v in var.users : k => v if element(v, 1) == "Instructors" }
  team_id  = github_team.instructors.id
  username = each.key
  role     = each.value[2]
}


#
# GH Team - Students
#
resource "github_team" "students" {
  name = "Students"
}

resource "github_team_membership" "students_member" {
  for_each = { for k, v in var.users : k => v if element(v, 1) == "Docs" }
  team_id  = github_team.students.id
  username = each.key
  role     = "member"
}
