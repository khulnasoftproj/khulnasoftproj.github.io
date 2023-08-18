---
sidebar_position: 50
---

# Checksum Verification

`khulnasoft >= v1.20.0`

[#427](https://github.com/khulnasoftproj/khulnasoft/issues/427)

Checksum Verification is a feature verifying downloaded assets with checksum.
Checksum Verification prevents the supply chain attack and allows you to install tools securely.

## See also

- [Tutorial](/docs/guides/checksum)
- [Configuration](/docs/reference/config/checksum)
- [Registry Configuration](/docs/reference/registry-config/checksum)
- Blogs
  - [2022-11-08 Checksum Verification by khulnasoft](https://dev.to/suzukishunsuke/checksum-verification-by-khulnasoft-5038)
  - [2022-10-10 khulnasoft CLI Version Manager が checksum の検証をサポート](https://zenn.dev/shunsuke_suzuki/articles/khulnasoft-checksum-verification)

## How it works

When a tool is installed, khulnasoft verifies the checksum as the following.

1. Download the tool in the temporal directory
1. Calculate the checksum from the downloaded file
1. Get the expected checksum
1. If the actual checksum is different from the expected checksum, make the installation failure
1. If the checksum isn't found in `khulnasoft-checksums.json`, the expected checksum is added to `khulnasoft-checksums.json`
1. Install the tool

khulnasoft gets the expected checksum from the following sources.

1. `khulnasoft-checksums.json`
1. checksum files that each tools publish
1. If the tool doesn't publish checkfum files, khulnasoft treats the checksum calculated from the downloaded asset as the expected checksum

e.g. `khulnasoft-checksums.json`

```json
{
  "checksums": [
    {
      "id": "github_release/github.com/golangci/golangci-lint/v1.49.0/golangci-lint-1.49.0-darwin-amd64.tar.gz",
      "checksum": "20cd1215e0420db8cfa94a6cd3c9d325f7b39c07f2415a02d111568d8bc9e271",
      "algorithm": "sha256"
    },
    {
      "id": "github_release/github.com/golangci/golangci-lint/v1.49.0/golangci-lint-1.49.0-darwin-arm64.tar.gz",
      "checksum": "cabb1a4c35fe1dadbe5a81550a00871281a331e7660cd85ae16e936a7f0f6cfc",
      "algorithm": "sha256"
    }
  ]
}
```

Many tools publish checksum files, so khulnasoft gets checksums from them.

e.g.

* [Terraform](https://releases.hashicorp.com/terraform/1.2.7/terraform_1.2.7_SHA256SUMS)
* [GitHub CLI](https://github.com/cli/cli/releases/download/v2.14.4/gh_2.14.4_checksums.txt)

If no checksum file for a tool is published, khulnasoft can also get checksums by downloading assets and calculating checksums.


## khulnasoft-registry version

From [v3.90.0](https://github.com/khulnasoftproj/khulnasoft-registry/releases/tag/v3.90.0), khulnasoft-registry supports the checksum verification.

## Remove unused checksums with `-prune` option

khulnasoft >= [v1.28.0](https://github.com/khulnasoftproj/khulnasoft/releases/tag/v1.28.0)

When tools are updated, checksums for old versions are basically unneeded.
Or when we remove some tools from `khulnasoft.yaml`, checksums for those tools would be unneeded.

You can remove unused checksums by setting `-prune` option.

```
khulnasoft update-checksum -prune
```

## Verify checksums of Registries

khulnasoft >= [v1.30.0](https://github.com/khulnasoftproj/khulnasoft/releases/tag/v1.30.0)

[#1491](https://github.com/khulnasoftproj/khulnasoft/issues/1491) [#1508](https://github.com/khulnasoftproj/khulnasoft/pull/1508)

khulnasoft verifies checksums of Registries if Checksum Verification is enabled.

khulnasoft.yaml

```yaml
checksum:
  enabled: true
```

khulnasoft-checksums.json

```json
{
  "checksums": [
    {
      "id": "registries/github_content/github.com/khulnasoftproj/khulnasoft-registry/v3.114.0/registry.yaml",
      "checksum": "b5b922c4d64609e536daffec6e480d0fed3ee56b16320a10c38ae12df7f045e8b20a0c05ec66eb28146cee42559e5e6c4e4bc49ce89ffe48a5640999cc6248bd",
      "algorithm": "sha512"
    }
  ]
}
```

If the checksum is invalid, it would fail to install Registries.

```
ERRO[0000] install the registry                          actual_checksum=b5b922c4d64609e536daffec6e480d0fed3ee56b16320a10c38ae12df7f045e8b20a0c05ec66eb28146cee42559e5e6c4e4bc49ce89ffe48a5640999cc6248be khulnasoft_version= env=darwin/arm64 error="check a registry's checksum: checksum is invalid" exe_name=starship expected_checksum=b5b922c4d64609e536daffec6e480d0fed3ee56b16320a10c38ae12df7f045e8b20a0c05ec66eb28146cee42559e5e6c4e4bc49ce89ffe48a5640999cc6248bd program=khulnasoft registry_name=standard
FATA[0000] khulnasoft failed                                   khulnasoft_version= env=darwin/arm64 error="it failed to install some registries" exe_name=starship program=khulnasoft
```

## Generate and patch checksum configuration automatically

It is bothersome to write the checksum configuration manually, so khulnasoft supports scaffolding the configuration.

[khulnasoft gr](/docs/develop-registry/scaffold-registry) scaffolds the checksum configuration too.

And you can also patch the checksum configuration to the existing registries by [khulnasoft-registry patch-checksum command](https://github.com/khulnasoftproj/registry-tool/blob/main/USAGE.md#khulnasoft-registry-patch-checksum).

:::caution
The scaffolding isn't perfect, so sometimes you have to fix the code manually.
:::

## Question: Should `khulnasoft-checksums.json` be managed with Git?

Yes. You should manage `khulnasoft-checksums.json` with Git.
