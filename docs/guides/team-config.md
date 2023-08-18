---
sidebar_position: 20
---

# Share khulnasoft configuration for teams and organizations

khulnasoft reads configuration from the environment variable `KHULNASOFT_GLOBAL_CONFIG`.
`KHULNASOFT_GLOBAL_CONFIG` is configuration file paths separated with semicolons `:`.

e.g.

```sh
export KHULNASOFT_GLOBAL_CONFIG="/home/foo/khulnasoft-config/sre.yaml:/home/foo/khulnasoft-config/all.yaml:${KHULNASOFT_GLOBAL_CONFIG:-}"
```

About the priority of configuration, please see [Configuration File Path](/docs/reference/config/#configuration-file-path).

By default `khulnasoft i` ignores Global Configuration.
If `--all (-a)` is set, khulnasoft installs all packages including Global Configuration.

## How to share khulnasoft configuration for teams and organizations

Let's create the repository in your GitHub Organization,
and add khulnasoft configuration files for your teams and organization into the repository.

e.g.

```
khulnasoft-config/
  all.yaml # khulnasoft configuration for all developers in your organization
  sre.yaml # khulnasoft configuration for your SRE team
```

Then checkout the repository and set the environment variable `KHULNASOFT_GLOBAL_CONFIG`.
If you belong to SRE team,

```sh
export KHULNASOFT_GLOBAL_CONFIG="/home/foo/khulnasoft-config/sre.yaml:/home/foo/khulnasoft-config/all.yaml:${KHULNASOFT_GLOBAL_CONFIG:-}"
```

Otherwise

```sh
export KHULNASOFT_GLOBAL_CONFIG="/home/foo/khulnasoft-config/all.yaml:${KHULNASOFT_GLOBAL_CONFIG:-}"
```
