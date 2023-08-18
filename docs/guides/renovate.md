---
sidebar_position: 10
---

# Update packages by Renovate

```json
{
  "extends": [
    "github>khulnasoftproj/khulnasoft-renovate-config#1.1.0"
  ]
}
```

![image](https://user-images.githubusercontent.com/13323303/176582627-44f27c48-213b-44da-b18f-d4d482ef2f56.png)

khulnasoft manages package and registry versions,
so it is important to update them continuously.
khulnasoft doesn't provide sub commands like `khulnasoft update` or options like `khulnasoft install --update`.
We recommend managing `khulnasoft.yaml` with Git and update versions by [Renovate](https://docs.renovatebot.com/) or something.

Using Renovate's [Regex Manager](https://docs.renovatebot.com/modules/manager/regex/), you can update versions.

We provide the Renovate Preset Configuration [khulnasoft-renovate-config](https://github.com/khulnasoftproj/khulnasoft-renovate-config). For the detail, please see the [README](https://github.com/khulnasoftproj/khulnasoft-renovate-config).

Example pull requests by Renovate.

* [chore(deps): update dependency golangci/golangci-lint to v1.42.0](https://github.com/khulnasoftproj/khulnasoft/pull/193)
* [chore(deps): update dependency khulnasoftproj/khulnasoft-registry to v0.2.2](https://github.com/khulnasoftproj/khulnasoft/pull/194)

## :bulb: Schedule Standard Registry's update

The release frequency of [Standard Registry](https://github.com/khulnasoftproj/khulnasoft-registry) is high.
If you feel the update of Standard Registry is a bit noisy, you can schedule the update of Standard Registry.

- [schedule | Renovate](https://docs.renovatebot.com/configuration-options/#schedule)
- [Schedule Presets | Renovate](https://docs.renovatebot.com/presets-schedule/)

e.g.

```json
{
  "packageRules": [
    {
      "matchPackageNames": ["khulnasoftproj/khulnasoft-registry"],
      "extends": ["schedule:earlyMondays"]
    }
  ]
}
```

## :bulb: Prevent some packages from being updated by Renovate

There are two ways to prevent some packages from being updated by Renovate.

1. [Renovate's enabled option](https://docs.renovatebot.com/configuration-options/#enabled)
2. Use the long syntax instead of the short syntax

### 1. Renovate's enabled option

e.g. renovate.json

```json
{
  "packageRules": [
    {
      "matchPackageNames": ["kubernetes/kubectl"],
      "enabled": false
    }
  ]
}
```

### 2. Use the long syntax instead of the short syntax

e.g. khulnasoft.yaml

:thumbsup: Renovate wouldn't update `kubernetes/kubectl`.

```yaml
packages:
- name: kubernetes/kubectl
  version: v1.25.0
```

:thumbsdown: Renovate would update `kubernetes/kubectl` and `sulaiman-coder/tfcmt`.

```yaml
packages:
- name: kubernetes/kubectl@v1.25.0
- name: sulaiman-coder/tfcmt
  version: v2.0.0 # renovate: depName=sulaiman-coder/tfcmt
```
