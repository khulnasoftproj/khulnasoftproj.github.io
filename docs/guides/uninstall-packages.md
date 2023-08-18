---
sidebar_position: 500
---

# Uninstall Packages

[#538](https://github.com/khulnasoftproj/khulnasoft/issues/538)

khulnasoft installs packages in `$KHULNASOFT_ROOT_DIR}/pkgs` and doesn't remove them.
Even if you change the package version, khulnasoft doesn't remove the old package.

**khulnasoft doesn't have a command to uninstall packages, because we think the feature is unnecessary.**
To keep khulnasoft simple, it is important not to implement unnecessary features.

For khulnasoft, `uninstall a package` can mean the following things.

1. Remove a package from `khulnasoft.yaml`
1. Remove symbolic links in PATH `$KHULNASOFT_ROOT_DIR/bin`
1. Remove packages from `$KHULNASOFT_ROOT_DIR/pkgs`

> 1. Remove a package from `khulnasoft.yaml`

Please edit `khulnasoft.yaml` with editor.

> 2. Remove symbolic links in PATH `$KHULNASOFT_ROOT_DIR/bin`

Basically, you don't have to remove links because khulnasoft supports finding commands from `PATH` if the command isn't found in `khulnasoft.yaml`.

[How does Lazy Install work?](/docs/reference/lazy-install#how-does-lazy-install-work)

> If the package isn't found in the configuration files,
> khulnasoft finds the command from the environment variable `PATH`.

If you want to remove links by all means, you can remove links by `rm "$(which COMMAND)"`.

> 3. Remove packages from `$KHULNASOFT_ROOT_DIR/pkgs`

Unlike decades, currently the storage is large and cheap.

If the storage is not exhausted, normally you don't have to remove old packages.
And if if the storage is exhausted, you should remove `${KHULNASOFT_ROOT_DIR}/pkgs` rather than picking out removed packages one by one.

khulnasoft reinstalls packages automatically by Lazy Install, so you don't have to reinstall them explicitly.

```console
$ rm -R "~/.local/share/khulnasoftproj-khulnasoft/pkgs"
```

If you want to uninstall the specific package or package version by all means, you can do them by simply remove directories.

```console
$ rm -R ~/.local/share/khulnasoftproj-khulnasoft/pkgs/github_release/github.com/sulaiman-coder/akoi
```

```console
$ rm -R ~/.local/share/khulnasoftproj-khulnasoft/pkgs/github_release/github.com/sulaiman-coder/akoi/v2.2.0
```
