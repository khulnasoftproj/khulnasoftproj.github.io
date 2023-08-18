---
sidebar_position: 600
---

# Install tools globally

khulnasoft finds the configuration files from the current directory to the root directory.

```console
$ pwd
/tmp
$ gh version
FATA[0000] khulnasoft failed                                   khulnasoft_version=1.19.2 error="command is not found" exe_name=gh program=khulnasoft
```

If you want to install tools regardless the current directory,
let's add the global configuration.
Create a global configuration file and add the path to the environment variable `KHULNASOFT_GLOBAL_CONFIG`.
You can change the global configuration file path freely.

```console
$ mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/khulnasoftproj-khulnasoft"
$ vi "${XDG_CONFIG_HOME:-$HOME/.config}/khulnasoftproj-khulnasoft/khulnasoft.yaml"
$ export KHULNASOFT_GLOBAL_CONFIG=${KHULNASOFT_GLOBAL_CONFIG:-}:${XDG_CONFIG_HOME:-$HOME/.config}/khulnasoftproj-khulnasoft/khulnasoft.yaml
```

```yaml
registries:
- type: standard
  ref: v3.90.0 # renovate: depName=khulnasoftproj/khulnasoft-registry

packages:
- name: cli/cli@v2.2.0
- name: junegunn/fzf@0.28.0
```

```console
$ gh version
gh version 2.2.0 (2021-10-25)
https://github.com/cli/cli/releases/tag/v2.2.0
```

## `khulnasoft i` ignores global configuration by default

:::caution
`khulnasoft i` ignores global configuration by default.
To install tools of global configuration by `khulnasoft i`, please set the `-a` option.

```console
$ khulnasoft i -a
```
:::

## See also

- [Share khulnasoft configuration for teams and organizations](/docs/guides/team-config)
- [Install Standard Registry's all packages very quickly](/docs/guides/install-all-packages)
