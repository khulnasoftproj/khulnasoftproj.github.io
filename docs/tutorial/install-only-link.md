---
sidebar_position: 400
---

# `khulnasoft i`'s `-l` option

You added [tfmigrator/cli](https://github.com/tfmigrator/cli) in [Search packages](search-packages.md), but it isn't installed yet.

```console
$ command -v tfmigrator # command is not found

```

Let's run `khulnasoft i -l`.

```console
$ khulnasoft i -l
INFO[0000] create a symbolic link                        khulnasoft_version=1.19.2 link_file=/home/foo/.local/share/khulnasoftproj-khulnasoft/bin/tfmigrator new=khulnasoft-proxy program=khulnasoft
```

The command would exit immediately, because the tool isn't downloaded and installed yet.

The command `khulnasoft i` installs all tools at once.
But when the option `-l` is set, `khulnasoft i` creates only symbolic links in `${KHULNASOFT_ROOT_DIR}/bin` and skips downloading and installing tools.

Even if downloading and installing are skipped, you can execute the tool thanks for [Lazy Install](lazy-install.md).

```console
$ tfmigrator -v
INFO[0000] download and unarchive the package            khulnasoft_version=1.19.2 package_name=tfmigrator/cli package_version=v0.2.1 program=khulnasoft registry=standard
tfmigrator version 0.2.1 (3993c0824016673338530f4e7e8966c35efa5706)
```

`-l` option is useful for local development, because you can install only tools which are needed for you.
