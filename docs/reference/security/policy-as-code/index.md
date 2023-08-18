---
sidebar_position: 80
---

# Policy as Code

`khulnasoft >= v1.24.0`

[#1306](https://github.com/khulnasoftproj/khulnasoft/issues/1306)

See also.

- [Guides > Policy as Code](/docs/guides/policy-as-code)
- [Why is Policy needed?](why-policy-is-needed.md)
- [Git Repository root's policy file and policy commands](git-policy.md)

## Change Logs

- v2.3.0: Support `Git Repository root's policy file` and policy commands
- v2.1.0: Support `KHULNASOFT_DISABLE_POLICY`
- v2.0.0: khulnasoft allows only Standard Registry by default
- v1.24.0: Introduce Policy

## Disable Policy

khulnasoft >= v2.1.0 [#1790](https://github.com/khulnasoftproj/khulnasoft/issues/1790)

:::caution
We don't recommend this feature basically because Policy is important in terms of security.
This feature is introduced to enable users using non Standard Registries to upgrade khulnasoft to v2 easily.
You shouldn't use this feature in CI.
:::

If `KHULNASOFT_DISABLE_POLICY` is `true`, Policy is disabled and every Registry and Package are available.

## Policy Types

There are two types of Policies

1. [Git Repository root's policy file](git-policy.md)
1. [KHULNASOFT_POLICY_CONFIG](#khulnasoft_policy_config)

We recommend `Git Repository root's policy file` instead of `KHULNASOFT_POLICY_CONFIG`.
`Git Repository root's policy file` was introduced to solve the issue of `KHULNASOFT_POLICY_COFIG`.
Please see [Why is `Git Repository root's policy file` needed](git-policy.md#why-this-feature-is-needed).

## KHULNASOFT_POLICY_CONFIG

You can specify Policy file paths by the environment variable `KHULNASOFT_POLICY_CONFIG`.

e.g.

```sh
export KHULNASOFT_POLICY_CONFIG=$PWD/khulnasoft-policy.yaml:$KHULNASOFT_POLICY_CONFIG
```

Unlike `Git Repository root's policy file`, you don't have to run `khulnasoft policy allow` command to allow Policy files.
