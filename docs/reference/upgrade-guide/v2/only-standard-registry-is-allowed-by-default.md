---
sidebar_position: 100
---

# Only standard registry is allowed by default

[#1404](https://github.com/khulnasoftproj/khulnasoft/issues/1404) [#1516](https://github.com/khulnasoftproj/khulnasoft/pull/1516)

If you don't set policies, khulnasoft uses the default policy allowing only standard registries.
If you set policies the default policy is ignored.

## See also

- [Tutorial - Policy](/docs/guides/policy-as-code)
- [Reference - Policy](/docs/reference/security/policy-as-code)
- [Reference - Git Repository root's policy file and policy commands](/docs/reference/security/policy-as-code/git-policy)

## Why this change is needed

This change makes khulnasoft secure by default.
Almost users don't need registries other than standard registry.
Other registries are useful but also can be abused.

## How to migrate

:::info
If it is difficult to configure Policy as we describe below, you can also disable Policy by the environment variable. Please see [here](/docs/reference/security/policy-as-code/#disable-policy).
Note that we don't recommend disabling Policy in terms of security.
:::

If you use only standard registry, you don't have to do anything.
Otherwise you have to set policies to allow non Standard Registries.

There are two ways to set policies.

1. (Recommended. `khulnasoft >= v2.3.0`) Add Policy files in your Git Repository's root directory and allow them by `khulnasoft policy allow` command.
1. Add Policy files and set the environment variable `KHULNASOFT_POLICY_CONFIG`

### Git Repository's root's policy file

`khulnasoft >= v2.3.0`

Please create a Policy file in your Git Repository's root directory.

```sh
khulnasoft policy init
vi khulnasoft-policy.yaml
khulnasoft policy allow
```

If you don't use Git, please run `git init` to create a directory `.git`.
You don't have to commit files. khulnasoft searches `.git` to search `Git Repository's root policy file`.

### KHULNASOFT_POLICY_CONFIG

If non Standard Registries are used in Global Configuration, it is useful to set `KHULNASOFT_POLICY_CONFIG` in `.bashrc` or something.

e.g. .bashrc

```sh
export KHULNASOFT_GLOBAL_CONFIG="$HOME/repos/src/github.com/khulnasoftproj/khulnasoft-registry/khulnasoft-all.yaml"
export KHULNASOFT_POLICY_CONFIG="$HOME/repos/src/github.com/khulnasoftproj/khulnasoft-registry/khulnasoft-policy.yaml"
```

If non Standard Registries are used in non Global Configuration, it would be useful to set `KHULNASOFT_POLICY_CONFIG` by [direnv](https://github.com/direnv/direnv) or something.

e.g. .envrc

```sh
export KHULNASOFT_POLICY_CONFIG=$PWD/khulnasoft-policy.yaml:$KHULNASOFT_POLICY_CONFIG
```

You can specify multiple policy files in `KHULNASOFT_POLICY_CONFIG` with `:` and empty stings are ignored.
