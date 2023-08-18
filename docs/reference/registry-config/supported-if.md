---
sidebar_position: 1900
---

# supported_if

:::caution
From khulnasoft v1.12.0 or later, we strongly recommend [supported_envs](supported-envs.md) instead of supported_if.
supported_envs is simpler than supported_if, and better in terms of the performance.
:::

[#438](https://github.com/khulnasoftproj/khulnasoft/pull/438) [#439](https://github.com/khulnasoftproj/khulnasoft/pull/439)

Some packages are available on only the specific environment.
For example, some packages are available on only Linux, or don't support Linux ARM64.

`supported_if` is [expr](https://github.com/antonmedv/expr)'s expression.
The evaluation result must be a boolean.

If the evaluation result is `false`, khulnasoft skips installing the package and outputs the debug log.
If `supported_if` isn't set, the package is always installed.

The following values and functions are accessible in the expression.

* `GOOS`: (type: `string`) Go's [runtime.GOOS](https://pkg.go.dev/runtime#pkg-constants)
* `GOARCH`: (type: `string`) Go's [runtime.GOARCH](https://pkg.go.dev/runtime#pkg-constants)

For example, if the following configuration indicates the package doesn't support macOS.

```yaml
supported_if: GOOS != "darwin"
```
