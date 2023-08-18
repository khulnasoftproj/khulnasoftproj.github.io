---
sidebar_position: 200
---

# Create a local Registry

Please see the Registry Configuration in the Standard Registry.

https://github.com/khulnasoftproj/khulnasoft-registry/blob/v0.10.10/registry.yaml#L1838-L1842

```yaml
- type: github_release
  repo_owner: sulaiman-coder
  repo_name: tfcmt
  asset: 'tfcmt_{{.OS}}_{{.Arch}}.tar.gz'
  description: Fork of mercari/tfnotify
```

`sulaiman-coder/tfcmt` is actually included in the Standard Registry, but let's assume this isn't included in the Standard Registry.

In that case, please write the following configuration.

ref. [local registry](/docs/reference/config#local-registry)

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
  type: local
  path: registry.yaml

packages:
- name: sulaiman-coder/tfcmt@v3.2.4
  registry: foo
```
