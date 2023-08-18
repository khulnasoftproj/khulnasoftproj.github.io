---
sidebar_position: 50
---

# khulnasoft-registry

khulnasoft's Standard Registry

https://github.com/khulnasoftproj/khulnasoft-registry

## Search packages from the Standard Registry by the command `khulnasoft g`

Please add the Standard Registry to your khulnasoft.yaml's registries, and run `khulnasoft g`.

```yaml
registries:
  - type: standard
    ref: v3.143.0 # renovate: depName=khulnasoftproj/khulnasoft-registry
```

`khulnasoft g` launches the interactive UI and you can search the package by fuzzy search.

```console
  koki-develop/clive                    ┌──────────────────────────────────────┐
  tektoncd/cli [tkn]                    │ climech/grit                         │
  ipinfo/cli/grepip                     │                                      │
  ipinfo/cli/randip                     │ https://github.com/climech/grit      │
  openfaas/faas-cli                     │ Multitree-based personal task m      │
  yitsushi/totp-cli                     │ anager                               │
  databricks/click                      │                                      │
  ipinfo/cli/prips                      │                                      │
  civo/cli [civo]                       │                                      │
  dapr/cli [dapr]                       │                                      │
  goark/gimei-cli                       │                                      │
  orhun/git-cliff                       │                                      │
  snyk/cli [snyk]                       │                                      │
  spf13/cobra-cli                       │                                      │
  volta-cli/volta                       │                                      │
  barnybug/cli53                        │                                      │
  cli/cli [gh]: github                  │                                      │
  nuclio/nuclio                         │                                      │
  cswank/kcli                           │                                      │
> climech/grit                          │                                      │
  140/1017                              │                                      │
> cli
```

## Request for new packages

Please check [registry.yaml](https://github.com/khulnasoftproj/khulnasoft-registry/blob/main/registry.yaml) or search packages by `khulnasoft g` command.
If the packages you want aren't found, please create issues or send pull requests!

By adding various packages to the standard registry, khulnasoft becomes more useful and attractive.
We need your contribution!

## Contributing

Please see [Contributing](contributing.md).

## :bulb: Tips: Get all packages in your laptop

[Install Standard Registry's all packages very quickly](/docs/guides/install-all-packages)
