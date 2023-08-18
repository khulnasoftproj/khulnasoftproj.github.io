---
sidebar_position: 200
---

# If `KHULNASOFT_CONFIG` or `-c` option is set, khulnasoft doesn't search configuration files recursively

[#1410](https://github.com/khulnasoftproj/khulnasoft/issues/1410) [#1516](https://github.com/khulnasoftproj/khulnasoft/pull/1516)

## Why this change is needed

If we specify the configuration file path explicitly, we would like to use the configuration file and shouldn't use other configuration files.
The current behaviour is a bit confusing and causes unneeded package installation.
