---
sidebar_position: 30
---

# Keep configuration files in one directory

- khulnasoft >= v1.33.0 [#1595](https://github.com/khulnasoftproj/khulnasoft/issues/1595)
- [update-checksum-action](https://github.com/khulnasoftproj/update-checksum-action) >= v0.2.0
- [update-checksum-workflow](https://github.com/khulnasoftproj/update-checksum-workflow) >= v0.1.1

khulnasoft has several configuration files such as `khulnasoft.yaml`, [khulnasoft-checksums.json](checksum.md), [policy file](/docs/reference/security/policy-as-code), and [imported files](split-config.md).

e.g.

```
khulnasoft.yaml
khulnasoft-checksums.json
khulnasoft-policy.yaml # You can rename freely
khulnasoft/ # You can rename freely
  terraform.yaml
  ...
```

From khulnasoft v1.33.0, khulnasoft supports keeping configuration files in one directory.

e.g.

```
khulnasoft/ # or .khulnasoft
  khulnasoft.yaml
  khulnasoft-checksums.json
  policy.yaml # You can rename freely
  imports/ # You can rename freely
    terraform.yaml
    ...
```

This is useful to keep the working directory clean.

## How to migrate

- Update khulnasoft to v1.33.0 or later
- Update [update-checksum-action](https://github.com/khulnasoftproj/update-checksum-action) to v0.2.0 or later
- Update [update-checksum-workflow](https://github.com/khulnasoftproj/update-checksum-workflow) to v0.1.1 or later
- Move files
  - khulnasoft.yaml => khulnasoft/khulnasoft.yaml
  - khulnasoft-checksums.json => khulnasoft/khulnasoft-checksums.json
  - khulnasoft-policy.yaml => khulnasoft/policy.yaml # rename freely
  - [imported files](split-config.md) => khulnasoft/imports/*.yaml # change the filename freely
- Fix [KHULNASOFT_POLICY_CONFIG](/docs/reference/security/policy-as-code)
- Fix GitHub Actions Path filters
- Fix [khulnasoft-renovate-config](https://github.com/khulnasoftproj/khulnasoft-renovate-config)'s file preset argument
