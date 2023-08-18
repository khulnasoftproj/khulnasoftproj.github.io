---
sidebar_position: 850
---

# khulnasoft doesn't support installing khulnasoft

khulnasoft doesn't support installing khulnasoft.
You shouldn't write the configuration to install the command `khulnasoft` with khulnasoft,
because it causes the infinite loop.

From khulnasoft v0.8.6 (khulnasoft-proxy v0.2.1), khulnasoft prevents the infinite loop.

```console
# Create the symbolic link accidentally
$ ln -s ~/.local/share/khulnasoftproj-khulnasoft/bin/khulnasoft-proxy ~/.local/share/khulnasoftproj-khulnasoft/bin/khulnasoft
$ khulnasoft i
[ERROR] the command "khulnasoft" can't be executed via khulnasoft-proxy to prevent the infinite loop
```

If you encounter the error `[ERROR] the command "khulnasoft" can't be executed via khulnasoft-proxy to prevent the infinite loop`,
remove the symbolic link `$KHULNASOFT_ROOT_DIR/bin/khulnasoft`.

```console
$ rm $KHULNASOFT_ROOT_DIR/bin/khulnasoft
```
