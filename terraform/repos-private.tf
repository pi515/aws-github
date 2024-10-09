variable "private_repos" {
  type = map(object({
    description = optional(string, null)
    has_wiki    = optional(bool, false)
  }))
  default = {
    tech_mentorship_2425_private = {
      description = "2024-2025 Tech Mentorship Class - Private Repo"
      has_wiki    = true
    }
  }
}

import {
  id = "tech-mentorship-2425-private"
  to = github_repository.private["tech_mentorship_2425_private"]
}
resource "github_repository" "private" {
  for_each                    = var.private_repos
  name                        = replace(each.key, "_", "-")
  description                 = each.value.description
  visibility                  = "private"
  license_template            = "mit"
  gitignore_template          = "Terraform"
  allow_auto_merge            = false
  allow_squash_merge          = true
  squash_merge_commit_title   = "COMMIT_OR_PR_TITLE"
  squash_merge_commit_message = "COMMIT_MESSAGES"
  allow_merge_commit          = false
  allow_rebase_merge          = false
  allow_update_branch         = true
  delete_branch_on_merge      = true
  archive_on_destroy          = true
  has_issues                  = true
  has_discussions             = false
  has_projects                = false
  has_wiki                    = each.value.has_wiki
  has_downloads               = false
  auto_init                   = true
  vulnerability_alerts        = true
}

resource "github_branch" "private_main" {
  for_each   = element(github_repository.private[*], 0)
  repository = each.value.name
  branch     = "main"
}

resource "github_branch_default" "private_main" {
  for_each   = element(github_repository.private[*], 0)
  repository = each.value.name
  branch     = github_branch.private_main[each.key].branch
}
