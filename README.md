# aws-github
[![main](https://github.com/pi515/aws-github/actions/workflows/main.yaml/badge.svg)](https://github.com/pi515/aws-github/actions/workflows/main.yaml)

Automated GitHub organization settings for [Pi515](https://www.pi515.org)
.

## Setup
**For Unix operating systems**, install [`homebrew`](https://brew.sh)
and then run the following:
```zsh
brew install gh
brew install pnpm
brew install awscli
brew install terraform
```

## Install
Install dependencies with [`pnpm`](https://pnpm.io)
.
```zsh
pnpm i
```

## Deployment Planning
Ask @ryanemcdaniel for organizational identity provider credentials and an AWS human-read role.

Use [`gh`](https://cli.github.com/manual/gh)
to authenticate the [GitHub provider](https://registry.terraform.io/providers/integrations/github/latest/docs)
.
```zsh
gh auth login
export GIT_TOKEN=$(gh auth token)
```

For convenience with root CWD, use these `pnpm` aliases for [`terraform`](https://www.terraform.io)
:
```zsh
pnpm run get
pnpm run init
pnpm run format # fmt -recursive
pnpm run select # workspace select
pnpm run plan
```
