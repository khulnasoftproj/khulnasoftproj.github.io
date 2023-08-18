---
sidebar_position: 700
---

# Trouble Shooting

## Use the latest khulnasoft and khulnasoft-registry

If khulnasoft and khulnasoft-registry are old, please update them.

## Set KHULNASOFT_LOG_LEVEL=debug

When khulnasoft doesn't work, the environment variable `KHULNASOFT_LOG_LEVEL` is helpful for the debug.

For example,

```console
$ KHULNASOFT_LOG_LEVEL=debug kind --help
DEBU[0000] CLI args                                      config= log_level=debug program=khulnasoft
DEBU[0000] install the package                           package_name=kubernetes-sigs/kind package_version=v0.11.1 program=khulnasoft registry=standard
DEBU[0000] check if the package is already installed     package_name=kubernetes-sigs/kind package_version=v0.11.1 program=khulnasoft registry=standard
DEBU[0000] check the permission                          file_name=kind
DEBU[0000] execute the command                           exe_path=/Users/shunsuke-suzuki/.khulnasoft/pkgs/http/kind.sigs.k8s.io/dl/v0.11.1/kind-darwin-amd64/kind-darwin-amd64 program=khulnasoft
DEBU[0000] command was executed but it failed            error="fork/exec /Users/shunsuke-suzuki/.khulnasoft/pkgs/http/kind.sigs.k8s.io/dl/v0.11.1/kind-darwin-amd64/kind-darwin-amd64: exec format error" exe_path=/Users/shunsuke-suzuki/.khulnasoft/pkgs/http/kind.sigs.k8s.io/dl/v0.11.1/kind-darwin-amd64/kind-darwin-amd64 exit_code=-1 program=khulnasoft
DEBU[0000] command failed                                error="fork/exec /Users/shunsuke-suzuki/.khulnasoft/pkgs/http/kind.sigs.k8s.io/dl/v0.11.1/kind-darwin-amd64/kind-darwin-amd64: exec format error" exit_code=-1 program=khulnasoft
```

In the above case, kind is already installed but the `exec format error` occurred. I reinstalled kind then the problem has been solved.

```console
# uninstall kind
$ rm -R /Users/shunsuke-suzuki/.khulnasoft/pkgs/http/kind.sigs.k8s.io/dl/v0.11.1/kind-darwin-amd64
# kind is reinstalled by Lazy Install
$ kind --help
```

## Tracing and CPU Profiling

If you encounter any performance issue, please see [Tracing and CPU Profiling](/docs/reference/config/trace-profile).

## check file_src is correct

If khulnasoft outputs the warning or error `check file_src is correct`,
this means that the asset was downloaded and unarchived but the executable file wasn't found.
Probably this is the problem of the Registry, so please update the Registry.

e.g.

```console
$ khulnasoft i
WARN[0000] check file_src is correct                     khulnasoft_version=1.15.1 env=darwin/arm64 error="exe_path isn't found: stat /Users/shunsukesuzuki/.local/share/khulnasoftproj-khulnasoft/pkgs/github_release/github.com/neovim/neovim/v0.7.2/nvim-macos.tar.gz/nvim-osx64/bin/nvim: no such file or directory" exe_path=/Users/shunsukesuzuki/.local/share/khulnasoftproj-khulnasoft/pkgs/github_release/github.com/neovim/neovim/v0.7.2/nvim-macos.tar.gz/nvim-osx64/bin/nvim file_name=nvim package=neovim/neovim package_name=neovim/neovim package_version=v0.7.2 program=khulnasoft registry=standard
```

In this case, the file `/Users/shunsukesuzuki/.local/share/khulnasoftproj-khulnasoft/pkgs/github_release/github.com/neovim/neovim/v0.7.2/nvim-macos.tar.gz/nvim-osx64/bin/nvim` wasn't found.

Please check the correct path.

```console
$ ls /Users/shunsukesuzuki/.local/share/khulnasoftproj-khulnasoft/pkgs/github_release/github.com/neovim/neovim/v0.7.2/nvim-macos.tar.gz
nvim-macos
```

The directory name was not `nvim-osx` but `nvim-macos`.

```console
$ ls /Users/shunsukesuzuki/.local/share/khulnasoftproj-khulnasoft/pkgs/github_release/github.com/neovim/neovim/v0.7.2/nvim-macos.tar.gz/nvim-macos/bin 
nvim
```

So we fixed the Standard Registry.

* https://github.com/khulnasoftproj/khulnasoft/issues/970#issuecomment-1171726476
* https://github.com/khulnasoftproj/khulnasoft-registry/pull/4419

## the asset isn't found

If khulnasoft outputs the error `the asset isn't found`, the following are possible causes.

* The release doesn't exist
  * Please fix the version
* GitHub Releases has no assets yet
  * Please wait for uploading assets. This isn't a problem of khulnasoft
  * Renovate's [stabilitydays](https://docs.renovatebot.com/configuration-options/#stabilitydays) may be useful to decrease this kind of issues
* Assets for only specific pair of OS and Arch aren't uploaded
  * Maybe you can request to release assets to the tool owner
  * e.g. https://github.com/gsamokovarov/jump/issues/72
* Asset name format was changed from the specific version
  * You have to fix the Registry
  * In case of the Standard Registry, please create an issue or a pull request

## GitHub API Rate Limit, 403 error

Please set GitHub Access Token to the environment variable `GITHUB_TOKEN` or `KHULNASOFT_GITHUB_TOKEN`.

## Packages aren't installed

Maybe your OS and Arch isn't supported by the package's [supported_envs](/docs/reference/registry-config/supported-envs).
Please check the Registry Configuration.

## Command is not found

If `command -v <command>` exits with non zero, the following are possible causes.

* `KHULNASOFT_ROOT_DIR/bin` (`KHULNASOFT_ROOT_DIR/bat` in case of PowerShell) isn't added to the environment variable `PATH`
  * e.g. `$ export PATH=$HOME/.local/share/khulnasoftproj-khulnasoft/bin:$PATH`
* the symbolic link isn't created in `KHULNASOFT_ROOT_DIR/bin`
  * Please run `khulnasoft i -l`
* the command name is wrong

You can check the package's command names by `khulnasoft g` command.
For example, the command name of the package `cli/cli` is `gh`.

```console
$ khulnasoft g
```

```
  docker-slim/docker-slim [docker-slim, docker-slim-sensor]
  corneliusweig/rakkess/access-matrix [kubectl-access_matrix]
  CircleCI-Public/circleci-cli [circleci]
> cli/cli [gh]: github
  4/660
> cli/cli
```

If the symbolic link isn't created by `khulnasoft i -l`, the following are possible causes.

* Your OS and Arch isn't supported by the package's [supported_envs](/docs/reference/registry-config/supported-envs)
* the package isn't added in configuration files

khulnasoft finds the configuration files and packages according to the rule.

* [Configuration file path | Tutorial](/docs/tutorial/config-path)
* [Configuration file paths | Reference](/docs/reference/config#configuration-file-path)

Please check configuration files and your current directory.

If `command -v <command>` exits with zero but command can't executed by the error `error="command is not found"`, the following are possible causes.

e.g.

```console
$ gh version
FATA[0000] khulnasoft failed                                   khulnasoft_version=1.19.2 error="command is not found" exe_name=gh program=khulnasoft
```

khulnasoft finds the configuration files and packages according to the rule.

* [Configuration file path | Tutorial](/docs/tutorial/config-path)
* [Configuration file paths | Reference](/docs/reference/config#configuration-file-path)

Please check configuration files and your current directory.

## gopls doesn't work well

This is a known issues.

- https://github.com/khulnasoftproj/khulnasoft/issues/1597
- https://github.com/khulnasoftproj/khulnasoft/issues/710

If you use Linux, please set the environment variable [KHULNASOFT_EXPERIMENTAL_X_SYS_EXEC](/docs/reference/config/experimental-feature/#khulnasoft_experimental_x_sys_exec).

```sh
export KHULNASOFT_EXPERIMENTAL_X_SYS_EXEC=true
```

[KHULNASOFT_EXPERIMENTAL_X_SYS_EXEC](/docs/reference/config/experimental-feature/#khulnasoft_experimental_x_sys_exec) has an issue in macOS.

https://github.com/khulnasoftproj/khulnasoft/issues/729

In macOS please try one of the following alias, shell function, and shell script.

1. alias

```sh
alias gopls="$(khulnasoft which gopls)"
```

2. shell function

```sh
gopls() {
  "$(khulnasoft which gopls)" "$@"
}
```

3. shell script

Add the following script `gopls` to `$PATH`.

```sh
#!/usr/bin/env bash

exec "$(khulnasoft which gopls)" "$@"
```
