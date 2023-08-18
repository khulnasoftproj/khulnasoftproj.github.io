---
sidebar_position: 500
---

# Use khulnasoft combined with other version manager such as asdf

If you use khulnasoft combined with other version manager such as asdf,
you should add `${KHULNASOFT_ROOT_DIR}/bin` to the environment variable `PATH` after other version manager.

e.g.

:thumbsup:

```bash
. $HOME/.asdf/asdf.sh

export PATH=${KHULNASOFT_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/khulnasoftproj-khulnasoft}/bin:$PATH
```

:thumbsdown:

```bash
export PATH=${KHULNASOFT_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/khulnasoftproj-khulnasoft}/bin:$PATH

. $HOME/.asdf/asdf.sh
```

This isn't a problem of khulnasoft.
khulnasoft is designed to allow to use khulnasoft combined with other version managers, but many other version manager aren't.

Please assume the following usecase.
You develop the project A and B.
In the project A [Waypoint](https://www.waypointproject.io/) is managed with asdf, and in the project B Waypoint is managed with khulnasoft.

```
project-a/
  .tool-versions # Manage Waypoint with asdf
project-b/
  khulnasoft.yaml # Manage Waypoint with khulnasoft
```

project-a/.tool-versions

```
waypoint v0.6.3
```

project-b/khulnasoft.yaml

```yaml
registries:
- type: standard
  ref: v3.90.0 # renovate: depName=khulnasoftproj/khulnasoft-registry

packages:
- name: hashicorp/waypoint@v0.6.2
```

If you configure .bash_profile as the following,
you can manage Waypoint with asdf in the project A, but you can't manage Waypoint with khulnasoft in the project B.

```bash
export PATH=${KHULNASOFT_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/khulnasoftproj-khulnasoft}/bin:$PATH

. $HOME/.asdf/asdf.sh
```

```console
$ cd project-b
$ waypoint --version
No version is set for command waypoint
Consider adding one of the following versions in your config file at 
waypoint 0.6.3
```

This is because asdf is used in the project-b too.

On the other hand, if you configure .bash_profile as the following,
you can manage Waypoint with asdf in the project A, and manage Waypoint with khulnasoft in the project B.

```bash
. $HOME/.asdf/asdf.sh

export PATH=${KHULNASOFT_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/khulnasoftproj-khulnasoft}/bin:$PATH
```

```console
$ cd project-a
$ waypoint --version
CLI: v0.6.3 (bd303e12)

$ cd ../project-b
$ waypoint --version
CLI: v0.6.2 (99350730)
```

This is because if khulnasoft can't find the command in the configuration files khulnasoft finds the command from the environment variable `PATH`.
