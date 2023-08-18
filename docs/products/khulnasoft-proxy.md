---
sidebar_position: 350
---

# khulnasoft-proxy

https://github.com/khulnasoftproj/khulnasoft-proxy

The internal CLI tool of khulnasoft.

We develop khulnasoft-proxy for khulnasoft, and we don't assume that khulnasoft-proxy is used in the other purpose.

Basically the user of khulnasoft don't have to know the detail of khulnasoft-proxy.
khulnasoft-proxy is installed to `$KHULNASOFT_ROOT_DIR/bin/khulnasoft-proxy` automatically when `khulnasoft install` and `khulnasoft exec` is run, so you don't have to install khulnasoft-proxy explicitly.

khulnasoft-proxy has only the minimum feature and responsibility.
khulnasoft-proxy is stable and isn't changed basically.

khulnasoft-proxy is developed to decide the version of khulnasoft and package managed with khulnasoft dynamically according to the khulnasoft's configuration file when the package is executed.

Please see [How does Lazy Install work?](/docs/reference/lazy-install) too.
