---
sidebar_position: 150
---

# khulnasoft-installer

A shell script and GitHub Actions to install khulnasoft

https://github.com/khulnasoftproj/khulnasoft-installer

* [Shell Script](#shell-script)
* [GitHub Actions](#github-actions)

## Shell Script

You can install khulnasoft by the following one liner.

```console
$ curl -sSfL https://raw.githubusercontent.com/khulnasoftproj/khulnasoft-installer/v2.1.1/khulnasoft-installer | bash
```

But the one liner is a bit dangerous because khulnasoft-installer may be tampered.
We recommend verifying khulnasoft-installer's checksum before running it.

```sh
curl -sSfL -O https://raw.githubusercontent.com/khulnasoftproj/khulnasoft-installer/v2.1.1/khulnasoft-installer
echo "c2af02bdd15da6794f9c98db40332c804224930212f553a805425441f8331665  khulnasoft-installer" | sha256sum -c
chmod +x khulnasoft-installer
./khulnasoft-installer
```

khulnasoft-installer installs khulnasoft to the following path.

* linux, macOS: `${KHULNASOFT_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/khulnasoftproj-khulnasoft}/bin/khulnasoft`
* windows: `${KHULNASOFT_ROOT_DIR:-$HOME/AppData/Local/khulnasoftproj-khulnasoft}/bin/khulnasoft`

:warning: From khulnasoft-installer v2, khulnasoft-installer doesn't support specifying the install path.

You can pass the following parameters.

* `-v [khulnasoft version]`: khulnasoft version

e.g.

```console
$ curl -sSfL https://raw.githubusercontent.com/khulnasoftproj/khulnasoft-installer/v2.1.1/khulnasoft-installer | bash -s -- -v v1.36.0
```

If the version isn't specified, the latest version would be installed.

## GitHub Actions

e.g.

```yaml
- uses: khulnasoftproj/khulnasoft-installer@v2.1.1
  with:
    khulnasoft_version: v2.3.1
```

```yaml
- uses: khulnasoftproj/khulnasoft-installer@v2.1.1
  with:
    khulnasoft_version: v2.3.1
    working_directory: foo
    khulnasoft_opts: ""
  env:
    KHULNASOFT_CONFIG: khulnasoft-config.yaml
    KHULNASOFT_LOG_LEVEL: debug
```

### Inputs

Please see [action.yaml](https://github.com/khulnasoftproj/khulnasoft-installer/blob/main/action.yaml) too.

#### Required Inputs

name | description
--- | --- 
khulnasoft_version | Installed khulnasoft version

#### Optional Inputs

:warning: From khulnasoft-installer v2, khulnasoft-installer doesn't support specifying the install path.

name | default | description
--- | --- | ---
enable_khulnasoft_install | `"true"` | if this is `"false"`, executing `khulnasoft i` and updating `GITHUB_PATH` are skipped
khulnasoft_opts | `-l` | `khulnasoft i`'s option. If you want to specify global options, please use environment variables
working_directory | `""` | working directory
policy_allow | `""` | khulnasoft >= `v2.3.0`. If this is `"true"`, `khulnasoft policy allow` command is run. If a Policy file path is set, `khulnasoft policy allow "${{inputs.policy_allow}}"` is run

### Outputs

Please see [action.yaml](https://github.com/khulnasoftproj/khulnasoft-installer/blob/main/action.yaml) too.

Nothing.

### :bulb: Caching

[#428](https://github.com/khulnasoftproj/khulnasoft-installer/issues/428)

khulnasoft-installer doesn't support caching, but you can cache packages and registries using `actions/cache`.

e.g.

```yaml
- uses: actions/cache@v3.3.1
  with:
    path: ~/.local/share/khulnasoftproj-khulnasoft
    key: v1-khulnasoft-installer-${{runner.os}}-${{runner.arch}}-${{hashFiles('khulnasoft.yaml')}}
    restore-keys: |
      v1-khulnasoft-installer-${{runner.os}}-${{runner.arch}}-
- uses: khulnasoftproj/khulnasoft-installer@v2.1.1
  with:
    khulnasoft_version: v2.6.0
```

Please fix `actions/cache`'s parameters properly.
If you [split `khulnasoft.yaml` using import](/docs/guides/split-config) or use local Registries, you may have to add hashes of them to key and restore-keys.

e.g.

```yaml
- uses: actions/cache@v3.3.1
  with:
    path: ~/.local/share/khulnasoftproj-khulnasoft
    key: v1-khulnasoft-installer-${{runner.os}}-${{runner.arch}}-${{hashFiles('.khulnasoft/*.yaml')}} # Change key
    restore-keys: |
      v1-khulnasoft-installer-${{runner.os}}-${{runner.arch}}-
```

khulnasoft-installer runs khulnasoft with [-l](https://khulnasoftproj.github.io/docs/tutorial/install-only-link) option by default, so packages that aren't run in the workflow aren't cached.
If you want to cache all packages, please set `khulnasoft_opts` to unset `-l` option.

```yaml
- uses: khulnasoftproj/khulnasoft-installer@v2.1.1
  with:
    khulnasoft_version: v2.6.0
    khulnasoft_opts: "" # Unset `-l` option
```

But if `-l` is unset, khulnasoft installs packages that aren't run in the workflow uselessly.

So it is up to you that whether and how you cache packages.
