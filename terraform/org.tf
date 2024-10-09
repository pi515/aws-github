data "aws_ssm_parameter" "gh_org_email" {
  name = "/pi515/github/email"
}

resource "github_organization_settings" "pi515" {
  billing_email = data.aws_ssm_parameter.gh_org_email.value
  location      = "United States of America"

  name          = "Pi515"
  company       = "Pi515"
  description   = "We outfit the next generation of leaders with tools to change their world."
  blog          = "https://www.pi515.org"
  email         = "tech@pi515.org"
  twitter_username = "Pi515_IA"

  default_repository_permission = "none"

  members_can_create_repositories         = false
  members_can_create_public_repositories  = false
  members_can_create_private_repositories = false
  members_can_fork_private_repositories   = false

  secret_scanning_enabled_for_new_repositories                 = true
  secret_scanning_push_protection_enabled_for_new_repositories = true
  dependabot_security_updates_enabled_for_new_repositories     = true
  dependency_graph_enabled_for_new_repositories                = true
  dependabot_alerts_enabled_for_new_repositories               = true
}
