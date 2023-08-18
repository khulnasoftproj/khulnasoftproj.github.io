---
sidebar_position: 300
---

# Add Packages to Registry

* Write Registry Configuration
  * [local registry](/docs/reference/config#local-registry)
  * [github_content registry](/docs/reference/config#github_content-registry)

## Write Registry Configuration

* [Registry Style Guide](/docs/develop-registry/registry-style-guide)
* [Registry Configuration](/docs/reference/registry-config)

## Create a GitHub Repository for Registry

ref. [github_content registry](/docs/reference/config#github_content-registry)

Create a repository for Registry and add Registry Configuration.

```yaml
# registry.yaml
packages:
- type: github_release
  repo_owner: sulaiman-coder
  repo_name: tfcmt
  asset: 'tfcmt_{{.OS}}_{{.Arch}}.tar.gz'
```

```yaml
# khulnasoft.yaml
registries:
- name: foo
  type: github_content
  repo_owner: sulaiman-coder
  repo_name: private-khulnasoft-registry # private repository
  ref: v0.1.0
  path: registry.yaml

packages:
- name: sulaiman-coder/tfcmt@v3.2.4
  registry: foo
```
