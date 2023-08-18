---
sidebar_position: 900
---

# Experimental Feature

[#725](https://github.com/khulnasoftproj/khulnasoft/issues/725), `khulnasoft >= v1.6.0`

khulnasoft supports the mechanithm for experimental features.
They are disabled by default, but you can enable them with environment variables or somehow.

Maybe experimental features would become enabled by default, or maybe they would be aborted.
khulnasoft conforms semantic versioning, so when there are breaking changes we release major update.
But experimental features are exception of semantic versioning, so maybe we abort them in the minor or patch update.

## KHULNASOFT_EXPERIMENTAL_X_SYS_EXEC

[#710](https://github.com/khulnasoftproj/khulnasoft/issues/710) [#715](https://github.com/khulnasoftproj/khulnasoft/pull/715) [#726](https://github.com/khulnasoftproj/khulnasoft/pull/726), `khulnasoft >= v1.6.0`

:::caution
Deprecated in khulnasoft v2.5.0.
Please see [KHULNASOFT_X_SYS_EXEC](/docs/reference/execve-2).
:::
