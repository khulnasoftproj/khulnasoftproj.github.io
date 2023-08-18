---
sidebar_position: 300
---

# Fix the default `files[].name`

[#1409](https://github.com/khulnasoftproj/khulnasoft/issues/1409) [#1516](https://github.com/khulnasoftproj/khulnasoft/pull/1516)

If the package has a `name` field, the `name` is split with `/` and the last element is used as the default file name.

For example, please see the following example.

```yaml
name: cert-manager/cert-manager/cmctl
repo_owner: cert-manager
repo_name: cert-manager
```

Then in khulnasoft v1 the default setting of `files` is the following.

```yaml
files:
- name: cert-manager
```

On the other hand, in khulnasoft v2 the default setting of `files` is the following.

```yaml
files:
- name: cmctl
```

## Why this change is needed

We think khulnasoft v2's default setting is better than khulnasoft v1 in many cases.

## How to migrate

If you maintain registries, you might have to fix them.
