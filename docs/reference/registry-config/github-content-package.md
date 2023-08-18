---
sidebar_position: 1000
---

# `github_content` Package

e.g. [khulnasoftproj/khulnasoft-installer](https://github.com/khulnasoftproj/khulnasoft-registry/blob/main/pkgs/khulnasoftproj/khulnasoft-installer/registry.yaml)

```yaml
packages:
  - type: github_content
    repo_owner: khulnasoftproj
    repo_name: khulnasoft-installer
    path: khulnasoft-installer
    description: Install khulnasoft quickly
```

## Required fields

* type
* repo_owner
* repo_name
* path: The template string of GitHub Content's file path
  * e.g. `'foo-{{title .OS}}.sh'`
