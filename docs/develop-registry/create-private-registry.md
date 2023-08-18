---
sidebar_position: 447
---

# Create Private Registries

If your GitHub organization has in-house tools,
it is useful to create a private registry in your organization.

khulnasoft provides the framework to build private registries.

The framework has the following components.

* [registry-tool](https://github.com/khulnasoftproj/registry-tool): CLI
* [template repository](https://github.com/khulnasoftproj/template-private-khulnasoft-registry)
* [registry-action](https://github.com/khulnasoftproj/registry-action): GitHub Actions

## How to use

1. [Create a repository from the template repository](https://github.com/khulnasoftproj/template-private-khulnasoft-registry/generate)
1. Replace placeholders `<REPO_OWNER>` and `<REPO_NAME>`
1. Prepare a GitHub App or GitHub Personal Access Token for CI
1. (Optional) Install Renovate App in the repository

## Prepare a GitHub App or GitHub Personal Access Token for CI

To test the registry in CI, GitHub Access Token is required to access private repositories.

We recommend creating a GitHub App and install it to private repositories.
You can also use GitHub Personal Access Token instead of GitHub App.

Then please set GitHub App ID and Private Key or Personal Access Token at GitHub Secrets and fix GitHub Actions Workflow `test` using secrets.

e.g.

```yaml
      - name: Generate token
        id: generate_token
        uses: tibdex/github-app-token@v1
        with:
          app_id: ${{ secrets.APP_ID }}
          private_key: ${{ secrets.APP_PRIVATE_KEY }}

      - uses: khulnasoftproj/registry-action/test@v0.1.0
        with:
          goos: ${{ matrix.env.goos }}
          goarch: ${{ matrix.env.goarch }}
          go_version: "1.18.5"
        env:
          GITHUB_TOKEN: ${{ steps.generate_token.outputs.token }}
```

## Renovate

You can test tool updates in CI using Renovate.
Please install Renovate in repositories.

### Automerge Renovate Pull Requests

If you would like to automerge Renovate Pull Requests, please enable automerge.

ref. [2022-03-29 Automate handling a number of Pull Requests by Renovate in Terraform Monorepo](https://devs.quipper.com/2022/03/29/automate-handling-a-number-of-pull-requests-by-renovate-in-terraform-monorepo.html)

- Enable Automerge
  - Add the job `status-check` to the default branch's branch protection rule's `Status checks that are required.`
- Enable platformAutomerge

## Contributing

### Requirements

- [khulnasoft](https://khulnasoftproj.github.io/docs/reference/install) >= [v1.14.0](https://github.com/khulnasoftproj/khulnasoft/releases/tag/v1.14.0)
- GitHub Access Token

GitHub Access Token is required to access private repositories.
Please set your GitHub Access Token as the environment variable `GITHUB_TOKEN` or `KHULNASOFT_GITHUB_TOKEN`. The scope `repo` is required.

### Set up

Checkout the repository and install [khulnasoft-registry CLI](https://github.com/khulnasoftproj/registry-tool).

```console
$ git checkout https://github.com/<REPO_OWNER>/<REPO_NAME>
$ cd <REPO_NAME>
$ khulnasoft i -l # Install khulnasoft-registry CLI
```

### How to add packages

1. Scaffold configuration: `khulnasoft-registry scaffold [--deep] <package name>`
1. Fix generated files if the scaffold fails
1. Update registry.yaml: `khulnasoft-registry gr`
1. Test: `khulnasoft i` and run installed tools
1. Repeat the step 2 ~ 4 until packages are installed properly
1. Create a pull request: `khulnasoft-registry create-pr-new-pkg <package name>...`

:::caution
Don't run `scaffold` command against the same package at multiple times.
:::

:::caution
When you update `pkgs/**/registry.yaml`, you have to run `khulnasoft-registry gr` to reflect the update to `registry.yaml` on the repository root directory.
:::

#### Generate `version_overrides` by `--deep` option

- registry-tool >= v0.1.8 [registry-tool#307](https://github.com/khulnasoftproj/registry-tool/pull/307)
- khulnasoft >= v1.34.0 [#1655](https://github.com/khulnasoftproj/khulnasoft/issues/1655) [#1662](https://github.com/khulnasoftproj/khulnasoft/pull/1662)

By default, `khulnasoft-registry scaffold` doesn't generate [version_constraint and version_overrides](/docs/reference/registry-config/version-overrides/).
You can generate them by `--deep` option.
`khulnasoft-registry scaffold --deep` calls `khulnasoft gr --deep` internally.

Please see [here](scaffold-registry.md#generate-version_overrides-by---deep-option) too.

#### Getting Started

Let's try to add [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep) to the registry.

```console
$ khulnasoft-registry scaffold BurntSushi/ripgrep
+ khulnasoft gr BurntSushi/ripgrep
 >> registry.yamlUpdate registry.yaml
Creating khulnasoft-local.yaml
+ khulnasoft g local,BurntSushi/ripgrep >> khulnasoft-local.yaml
+ khulnasoft g pkgs/BurntSushi/ripgrep/pkg.yaml >> BurntSushi/ripgrep
+ khulnasoft i --test
INFO[0000] create a symbolic link                        khulnasoft_version=1.19.2 env=darwin/arm64 link_file=/Users/shunsukesuzuki/.local/share/khulnasoftproj-khulnasoft/bin/ripgrep new=khulnasoft-proxy program=khulnasoft
ERRO[0000] install the package                           khulnasoft_version=1.19.2 env=darwin/arm64 error="check file_src is correct: exe_path isn't found: stat /Users/shunsukesuzuki/.local/share/khulnasoftproj-khulnasoft/pkgs/github_release/github.com/BurntSushi/ripgrep/13.0.0/ripgrep-13.0.0-x86_64-apple-darwin.tar.gz/ripgrep: no such file or directory" file_name=ripgrep package_name=BurntSushi/ripgrep package_version=13.0.0 program=khulnasoft registry=local
FATA[0000] khulnasoft failed                                   khulnasoft_version=1.19.2 env=darwin/arm64 error="it failed to install some packages" program=khulnasoft
FATA[0001] khulnasoft failed                                   khulnasoft_version=0.1.0-1 env=darwin/arm64 error="execute a command: khulnasoft i: exit status 1" program=khulnasoft-registry
```

When the scaffold fails, please see the log.

```
check file_src is correct: exe_path isn't found: stat /Users/shunsukesuzuki/.local/share/khulnasoftproj-khulnasoft/pkgs/github_release/github.com/BurntSushi/ripgrep/13.0.0/ripgrep-13.0.0-x86_64-apple-darwin.tar.gz/ripgrep: no such file or directory
```

:bulb: [Troubleshooting: check file_src is correct](/docs/trouble-shooting#check-file_src-is-correct)

Fix the configuration pkgs/BurntSushi/ripgrep/registry.yaml like [this](https://github.com/khulnasoftproj/khulnasoft-registry/blob/main/pkgs/BurntSushi/ripgrep/registry.yaml).

Then run `khulnasoft-registry gr` and `khulnasoft i`.

```console
$ khulnasoft-registry gr
$ khulnasoft i
```

Check the log and fix the following configuration files as needed.

- pkgs/BurntSushi/ripgrep/pkg.yaml
- pkgs/BurntSushi/ripgrep/registry.yaml
- khulnasoft-test.yaml

Run `rg --help` for testing.

```console
$ rg --help
```

If it doesn't work, check the log and fix the above configuration files.

When it works well, please create a pull request.

```console
$ khulnasoft-registry create-pr-new-pkg BurntSushi/ripgrep
```
