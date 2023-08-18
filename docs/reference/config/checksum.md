---
sidebar_position: 400
---

# Checksum

## Configuration file path

khulnasoft finds `khulnasoft-checksums.json` and `.khulnasoft-checksums.json`.
`khulnasoft-checksums.json` takes precedence over `.khulnasoft-checksums.json`.
If they don't exist, `khulnasoft-checksums.json` is created.

:::info
The checksum is case insensitive.
:::

## khulnasoft.yaml's checksum configuration

khulnasoft.yaml

```yaml
checksum:
  enabled: true # By default, this is false
  require_checksum: true # By default, this is false
  supported_envs: # By default, all envs are supported
    - darwin
    - linux
registries:
# ...
packages:
# ...
```

- `enabled`: If this is true, the checksum verification is enabled. By default `enabled` is `false`. If `enabled` is false, other settings such as `require_checksum` are ignored
- [`require_checksum`](#require_checksum)
- `supported_envs`: (khulnasoft >= [v1.29.0](https://github.com/khulnasoftproj/khulnasoft/releases/tag/v1.29.0)) If this is set, khulnasoft adds checksums of only specific platforms. This feature makes `khulnasoft-checksums.json` slim and avoids unneeded API call and download assets

### require_checksum

:::caution
The meaning of `require_checksum` was changed in khulnasoft v2.0.0.
:::

#### Environment variable

khulnasoft >= v1.38.0

You can enable `require_checksum` by the environment variable `KHULNASOFT_REQUIRE_CHECKSUM`.

```sh
export KHULNASOFT_REQUIRE_CHECKSUM=true
```

If `require_checksum` is set in a configuration file, `KHULNASOFT_REQUIRE_CHECKSUM` is ignored.

#### khulnasoft v1

If `require_checksum` is true, it fails to install a package when the checksum isn't found in `khulnasoft-checksums.json` and the package's checksum configuration is disabled.
By default, `require_checksum` is `false`.

#### khulnasoft v2

If this is true, it fails to install a package when the checksum isn't found in `khulnasoft-checksums.json`.
By default, `require_checksum` is `false`.
We strongly recommend enabling `require_checksum` to enforce the checksum verification.

To add checksums to `khulnasoft-checksums.json` before installing packages, please run `khulnasoft update-checksum`.

```console
$ khulnasoft update-checksum
```

If you manage `khulnasoft.yaml` with Git, you should manage `khulnasoft-checksums.json` with Git too. And we recommend [updating `khulnasoft-checksums.json` automatically by GitHub Actions](/docs/guides/checksum).
