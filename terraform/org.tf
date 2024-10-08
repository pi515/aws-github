data "aws_ssm_parameter" "gh_org_email" {
  name = "/pi515/github/email"
}

data "github_organization" "pi515" {
  name = "pi515"
}

resource "github_organization_settings" "pi515" {
  name          = "Pi515"
  billing_email = data.aws_ssm_parameter.gh_org_email.value
  location      = "United States of America"

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

import {
  id = data.github_organization.pi515.id
  to = github_organization_settings.pi515
}
