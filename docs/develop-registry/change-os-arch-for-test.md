---
sidebar_position: 850
---

# Change `GOOS` and `GOARCH` for testing Registry

[#643](https://github.com/khulnasoftproj/khulnasoft/issues/643) [#644](https://github.com/khulnasoftproj/khulnasoft/issues/644)

khulnasoft >= v1.4.0 is required.

When you develop khulnasoft Registry such as [Standard Registry](https://github.com/khulnasoftproj/khulnasoft-registry), you have to consider mainly the following platforms.

* windows / amd64
* windows / arm64
* darwin / amd64
* darwin / arm64
* linux / amd64
* linux / arm64

But if you don't have laptops for the above platforms, it is difficult to test the Registry on the platforms.

Furthermore, [Standard Registry](https://github.com/khulnasoftproj/khulnasoft-registry) is tested with GitHub Actions but GitHub Actions doesn't support arm64, so we can't test the Registry on arm64.

To solve the problem, khulnasoft supports changing `GOOS` and `GOARCH` for testing the Registry.

By default, khulnasoft gets `GOOS` and `GOARCH` from Go's [runtime.GOOS and runtime.GOARCH](https://pkg.go.dev/runtime#pkg-constants), but you can override them with the environment variables `KHULNASOFT_GOOS` and `KHULNASOFT_GOARCH`.

e.g.

```console
$ KHULNASOFT_GOOS=darwin KHULNASOFT_GOARCH=arm64 khulnasoft i --test
$ KHULNASOFT_GOOS=darwin KHULNASOFT_GOARCH=arm64 khulnasoft which gh
```

Of course, even if you change `GOOS` and `GOARCH` you wouldn't be able to execute the tools.
But by running `khulnasoft i --test`, you can test if tools can be installed properly.
