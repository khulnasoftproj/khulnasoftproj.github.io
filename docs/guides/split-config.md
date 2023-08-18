---
sidebar_position: 200
---

# Split the list of packages

You can split the list of packages.

e.g.

Directory structure

```
khulnasoft.yaml
khulnasoft/
  conftest.yaml
```

khulnasoft.yaml

```yaml
registries:
- type: standard
  ref: v3.90.0 # renovate: depName=khulnasoftproj/khulnasoft-registry

packages:
- import: khulnasoft/*.yaml
```

khulnasoft/conftest.yaml

```yaml
packages:
- name: open-policy-agent/conftest@v0.28.2
```

This is useful for CI.
You can execute test and lint only when the specific package is updated.

e.g. GitHub Actions' [`on.<push|pull_request>.paths`](https://docs.github.com/en/actions/learn-github-actions/workflow-syntax-for-github-actions#onpushpull_requestpaths)

```yaml
name: conftest
on:
  pull_request:
    paths:
    - policy/**.rego
    - khulnasoft/conftest.yaml
```

## :bulb: Renovate Config Preset

To update split files by Renovate, please use the preset [khulnasoftproj/khulnasoft-renovate-config:file](https://github.com/khulnasoftproj/khulnasoft-renovate-config#file-preset)

e.g.

```json
{
  "extends": [
    "github>khulnasoftproj/khulnasoft-renovate-config:file#1.5.0(khulnasoft/conftest\\.yaml)"
  ]
}
```

You can also use the regular expression.

```json
{
  "extends": [
    "github>khulnasoftproj/khulnasoft-renovate-config:file#1.5.0(khulnasoft/.*\\.ya?ml)"
  ]
}
```
