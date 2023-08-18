---
sidebar_position: 300
---

# update-checksum-workflow

https://github.com/khulnasoftproj/update-checksum-workflow

GitHub Actions Reusable Workflow to update khulnasoft-checksums.json
If khulnasoft-checksums.json isn't latest, update khulnasoft-checksums.json and push a commit

About khulnasoft's Checksum Verification, please see [the document](/docs/reference/security/checksum) too.

## Workflow

[Workflow](https://github.com/khulnasoftproj/update-checksum-workflow/blob/main/.github/workflows/update-checksum.yaml)

## Requirements

```console
$ khulnasoft g -i int128/ghcp
```

### Example

```yaml
name: update-khulnasoft-checksum
on:
  pull_request:
    paths:
      - khulnasoft.yaml
      - khulnasoft-checksums.json
jobs:
  update-khulnasoft-checksums:
    uses: khulnasoftproj/update-checksum-workflow/.github/workflows/update-checksum.yaml@f637ff2417a258303aeec16a7fa7a1a7a8bda020 # v0.1.3
    permissions:
      contents: read
    with:
      khulnasoft_policy_config: khulnasoft-policy.yaml
      khulnasoft_version: v1.36.0
      prune: true
    secrets:
      gh_app_id: ${{secrets.APP_ID}}
      gh_app_private_key: ${{secrets.APP_PRIVATE_KEY}}
```
