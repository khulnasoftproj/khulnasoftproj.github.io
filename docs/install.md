---
sidebar_position: 150
---

# Install

khulnasoft is a single binary written in Go.

1. Install the binary `khulnasoft` in `PATH`
1. add `${KHULNASOFT_ROOT_DIR}/bin` to the environment variable `PATH`

:::info
From khulnasoft v2.8.0, `khulnasoft root-dir` command is available.

```bash
export PATH="$(khulnasoft root-dir)/bin:$PATH"
```
:::

:::tip
If you use khulnasoft combined with other version manager such as asdf,
please add `${KHULNASOFT_ROOT_DIR}/bin` to the environment variable `PATH` after other version manager.
For detail, please see [here](/docs/reference/use-khulnasoft-with-other-tools).
:::

:::info
[Shell Completion](/docs/reference/config/shell-completion)
:::

## Windows

Please see [here](/docs/reference/windows-support#how-to-install).

## Homebrew

```sh
brew install khulnasoftproj/khulnasoft/khulnasoft
export PATH="${KHULNASOFT_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/khulnasoftproj-khulnasoft}/bin:$PATH"
```

## Install script, GitHub Actions

[khulnasoft-installer](/docs/products/khulnasoft-installer)

## CircleCI Orb

[circleci-orb-khulnasoft](/docs/products/circleci-orb-khulnasoft)

## Go

```sh
go install github.com/khulnasoftproj/khulnasoft/v2/cmd/khulnasoft@latest
```

## Download from GitHub Releases

https://github.com/khulnasoftproj/khulnasoft/releases
