---
sidebar_position: 100
---

# Git Repository root's policy file and policy commands

`khulnasoft >= v2.3.0`

[#1789](https://github.com/khulnasoftproj/khulnasoft/issues/1789) [1808](https://github.com/khulnasoftproj/khulnasoft/pull/1808)

`Git Repository root's policy file` is a Policy file in the Git Repository root directory.

`Git Repository root's policy file` must be located in one of the following paths from the Git Repository root directory.

- khulnasoft-policy.yaml
- .khulnasoft-policy.yaml
- khulnasoft/khulnasoft-policy.yaml
- .khulnasoft/khulnasoft-policy.yaml

:::caution
The file extension `.yml` isn't supported at the moment.
:::

Before khulnasoft executes or installs packages, khulnasoft searches `Git Repository root's policy file`.
khulnasoft searches the Git repository root directory from the current directory to the root directory.

- If `Git Repository root's policy file` isn't found, it is same as usual.
- If `Git Repository root's policy file` is found, khulnasoft checks if the policy file is already allowed or not.
- If `Git Repository root's policy file` is already allowed, khulnasoft uses `Git Repository root's policy file` as Policy.
- If `Git Repository root's policy file` isn't allowed, khulnasoft outputs the warning and ignores `Git Repository root's policy file`.

`khulnasoft policy allow` command is a command to allow a policy file.

```console
$ khulnasoft policy allow [<policy file path>]
```

If no argument is given, khulnasoft allows `Git Repository root's policy file`.

Even if you allow a policy file once, you have to allow the policy file again if the policy file is modified.

:::caution
Before you run `khulnasoft policy allow` command, you should confirm the content of khulnasoft-policy.yaml.
If untrusted Registries are used, you shouldn't run `khulnasoft policy allow`.
:::

`khulnasoft policy deny` command is a command to deny a policy file.

```console
$ khulnasoft policy deny [<policy file path>]
```

If no argument is given, khulnasoft allows `Git Repository root's policy file`.

`khulnasoft policy deny` is used to ignore `Git Repository root's policy file` and suppress the warning.

:::info
khulnasoft searches `Git Repository root's policy file` per `khulnasoft.yaml`. khulnasoft searches `Git Repository` based on the directory where `khulnasoft.yaml` is located.
:::

## How to use

1. Add `Git Repository root's policy file` to your Git repository
1. Run `khulnasoft policy allow` in the repository

Please see [Getting Started](/docs/guides/policy-as-code).

## Why this feature is needed

To improve the user experience of non Standard Registries.
To set up Policy easily keeping the security.

To use non Standard Registries, you had to set the environment variable `KHULNASOFT_POLICY_CONFIG`.
But it is bothersome, especially in the team development because all members have to set the environment variable `KHULNASOFT_POLICY_CONFIG`.
Some tools such as `direnv` are useful to set environment variables, but it is undesirable to ask users to install additional tools for khulnasoft.

So we would like to apply a policy without `KHULNASOFT_POLICY_CONFIG`, but at the same time we have to keep the security.

## Design consideration

Sometimes security and convenience are conflicted, so we have to be careful not to harm security for convenience.
To keep the security, I think khulnasoft should ask users to allow `Git Repository root's policy file` explicitly.
This means khulnasoft should not apply `Git Repository root's policy file` without user's approval.
So khulnasoft asks users to allow `Git Repository root's policy file` using `khulnasoft policy allow` command.

:::info
Unlike `Git Repository root's policy file`, khulnasoft uses policy files in `KHULNASOFT_POLICY_CONFIG` without your approval.
Because

- To keep the compatibility
- Unlike `Git Repository root's policy file`, the environment variable `KHULNASOFT_POLICY_CONFIG` is set by you, so khulnasoft regards `KHULNASOFT_POLICY_CONFIG` as your approval
:::
