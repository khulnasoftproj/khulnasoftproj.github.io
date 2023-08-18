---
sidebar_position: 1200
---

# Restriction

khulnasoft has some restrictions.

## khulnasoft doesn't support running any external commands to install tools

khulnasoft's install process is very simple.

1. Download tool
1. Unarchive tool in $KHULNASOFT_ROOT_DIR

khulnasoft doesn't support running external commands (except for [cosign](/docs/reference/security/cosign-slsa) and [go](/docs/reference/registry-config/go-install-package)) to install tools.
So khulnasoft can't support tools requiring to run external commands.

This is not necessarily a draw back.

https://github.com/khulnasoftproj/khulnasoft-registry/issues/987#issuecomment-1104422712

> You may think it's inconvenient, but we think this design is important to keep khulnasoft simple, secure, less dependency, and maintainable.
> 
> khulnasoft doesn't need any dependency.
> khulnasoft doesn't run external commands.
> khulnasoft doesn't change files outside install directory.
> 
> So the trouble shooting is relatively easy.
> Otherwise, user support would be very hard.
