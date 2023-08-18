---
sidebar_position: 100
---

# Quick Start

khulnasoft is a CLI tool to install CLI tools with declarative YAML configuration.
In this quick start, let's install khulnasoft and install tools with khulnasoft.

## Demo

Please see [Demo](https://asciinema.org/a/498262?autoplay=1).

## Install khulnasoft

Homebrew

```console
brew install khulnasoftproj/khulnasoft/khulnasoft
```

[khulnasoft-installer](https://github.com/khulnasoftproj/khulnasoft-installer)

```console
curl -sSfL -O https://raw.githubusercontent.com/khulnasoftproj/khulnasoft-installer/v2.1.1/khulnasoft-installer
echo "c2af02bdd15da6794f9c98db40332c804224930212f553a805425441f8331665  khulnasoft-installer" | sha256sum -c
chmod +x khulnasoft-installer
./khulnasoft-installer
```

Add `${KHULNASOFT_ROOT_DIR}/bin` to the environment variable `PATH`.

```bash
export PATH="${KHULNASOFT_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/khulnasoftproj-khulnasoft}/bin:$PATH"
```

:::info
From khulnasoft v2.8.0, `khulnasoft root-dir` command is available.

```bash
export PATH="$(khulnasoft root-dir)/bin:$PATH"
```
:::

Confirm if khulnasoft is installed correctly.

```console
khulnasoft -v
```

If you want to try this tutorial in the clean environment, container is useful.

```sh
docker run --rm -ti alpine:3.17.0 sh
```

```sh
apk add curl bash sudo
adduser -u 1000 -G wheel -D foo
visudo # Uncomment "%wheel ALL=(ALL) NOPASSWD: ALL"
su foo
mkdir ~/workspace
cd ~/workspace

export PATH="${KHULNASOFT_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/khulnasoftproj-khulnasoft}/bin:$PATH"
curl -sSfL -O https://raw.githubusercontent.com/khulnasoftproj/khulnasoft-installer/v2.1.1/khulnasoft-installer
echo "c2af02bdd15da6794f9c98db40332c804224930212f553a805425441f8331665  khulnasoft-installer" | sha256sum -c
chmod +x khulnasoft-installer
./khulnasoft-installer
```

## Create a configuration file

Create a configuration file by `khulnasoft init` command.

```console
$ khulnasoft init # khulnasoft.yaml is created
$ cat khulnasoft.yaml
---
# khulnasoft - Declarative CLI Version Manager
# https://khulnasoftproj.github.io/
registries:
- type: standard
  ref: v3.90.0 # renovate: depName=khulnasoftproj/khulnasoft-registry
packages:
```

`packages` is still empty, so let's add packages to install them.

## Install tools with khulnasoft

Let's install [GitHub Official CLI](https://cli.github.com/) and [fzf](https://github.com/junegunn/fzf) with khulnasoft.

Add packages to `khulnasoft.yaml`.

```console
$ khulnasoft g -i cli/cli junegunn/fzf
```

```yaml
---
# khulnasoft - Declarative CLI Version Manager
# https://khulnasoftproj.github.io/
registries:
- type: standard
  ref: v3.90.0 # renovate: depName=khulnasoftproj/khulnasoft-registry
packages:
- name: cli/cli@v2.2.0
- name: junegunn/fzf@0.28.0
```

Then run `khulnasoft i`.

```console
$ khulnasoft i 
INFO[0000] download and unarchive the package            khulnasoft_version=1.19.2 package_name=khulnasoft-proxy package_version=v0.2.1 program=khulnasoft registry=
INFO[0001] create a symbolic link                        khulnasoft_version=1.19.2 link_file=/home/foo/.local/share/khulnasoftproj-khulnasoft/bin/khulnasoft-proxy new=../pkgs/github_release/github.com
/khulnasoftproj/khulnasoft-proxy/v0.2.1/khulnasoft-proxy_linux_amd64.tar.gz/khulnasoft-proxy program=khulnasoft
INFO[0001] create a symbolic link                        khulnasoft_version=1.19.2 link_file=/home/foo/.local/share/khulnasoftproj-khulnasoft/bin/gh new=khulnasoft-proxy program=khulnasoft
INFO[0001] create a symbolic link                        khulnasoft_version=1.19.2 link_file=/home/foo/.local/share/khulnasoftproj-khulnasoft/bin/fzf new=khulnasoft-proxy program=khulnasoft
INFO[0001] download and unarchive the package            khulnasoft_version=1.19.2 package_name=cli/cli package_version=v2.2.0 program=khulnasoft registry=standard
INFO[0001] download and unarchive the package            khulnasoft_version=1.19.2 package_name=junegunn/fzf package_version=0.28.0 program=khulnasoft registry=standard
```

Congratulation! Tools are installed correctly.

```console
$ command -v gh
/home/foo/.local/share/khulnasoftproj-khulnasoft/bin/gh

$ gh version
gh version 2.2.0 (2021-10-25)
https://github.com/cli/cli/releases/tag/v2.2.0

$ command -v fzf
/home/foo/.local/share/khulnasoftproj-khulnasoft/bin/fzf

$ fzf --version
0.28.0 (e4c3ecc)
```

khulnasoft installs tools in `${KHULNASOFT_ROOT_DIR}`.
