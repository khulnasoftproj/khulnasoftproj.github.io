---
sidebar_position: 1600
---

# `overrides`

khulnasoft >= v1.3.0

[#607](https://github.com/khulnasoftproj/khulnasoft/issues/607)

You can override the following attributes on the specific `GOOS` and `GOARCH`.

* replacements
* format
* asset
* url
* files
* checksum
* complete_windows_ext
* windows_ext
* type

e.g. On Linux ARM64, `Arch` becomes `aarch64`.

```yaml
  overrides:
  - goos: linux
    replacements:
      arm64: aarch64
```

In case of `replacements`, maps are merged.

Either `goos` or `goarch` is required.

e.g.

```yaml
  asset: arkade
  overrides:
  - goos: linux
    goarch: arm64
    asset: 'arkade-{{.Arch}}'
  - goos: darwin
    goarch: amd64
    asset: 'arkade-darwin'
  - goos: darwin 
    asset: 'arkade-darwin-{{.Arch}}'
```

Even if multiple elements are matched, only first element is applied.
For example, Darwin AMD64 matches with second element but the second element isn't applied because the first element is matched.

```yaml
  - goos: darwin
    goarch: amd64
    asset: 'arkade-darwin'
  - goos: darwin 
    asset: 'arkade-darwin-{{.Arch}}'
```
