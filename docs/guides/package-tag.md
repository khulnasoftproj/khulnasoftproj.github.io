---
sidebar_position: 550
---

# Filter packages with tags

`khulnasoft >= v1.23.0`

[#441](https://github.com/khulnasoftproj/khulnasoft/issues/441) [#1336](https://github.com/khulnasoftproj/khulnasoft/pull/1336)

`khulnasoft cp` and `khulnasoft install` commands support filtering packages with tags.

## Specification

The optional field `tags` can be specified in `khulnasoft.yaml`'s package.
This field is a string list of tags.

e.g.

```yaml
---
registries:
- type: standard
  ref: v3.90.0 # renovate: depName=khulnasoftproj/khulnasoft-registry
packages:
- name: sulaiman-coder/tfcmt@v3.2.0
  tags:
    - test
    - foo
- name: sulaiman-coder/github-comment@v4.0.0
- name: cli/cli@v2.0.0
  tags:
    - bar
    - foo
```

And `khulnasoft install` and `khulnasoft cp` command have the following command line options.

- `--tags (-t)` (string): When this option is set, only packages that have specified tags are installed. You can specify multiple tags joining with `,` (e.g. `-t ci,test`)
- `--exclude-tags` (string): When this option is set, packages that have specified tags aren't installed. You can specify multiple tags joining with `,` (e.g. `-exclude-tags ci,test`)

In case of the above `khulnasoft.yaml`, you can filter packages as the following.

```console
$ khulnasoft i # Install sulaiman-coder/tfcmt@v3.2.0 and sulaiman-coder/github-comment@v4.0.0 and cli/cli@v2.0.0
$ khulnasoft i -t test # Install sulaiman-coder/tfcmt@v3.2.0
$ khulnasoft i -t foo,bar # Install sulaiman-coder/tfcmt@v3.2.0 and cli/cli@v2.0.0
$ khulnasoft i --exclude-tags test # Install sulaiman-coder/github-comment@v4.0.0 and cli/cli@v2.0.0
$ khulnasoft i --exclude-tags test -t foo # Install cli/cli@v2.0.0
```

:::caution
Note that `khulnasoft install` creates symbolic links of all packages regardless tags, so that you can execute all tools by Lazy Install and assure that tools are managed by khulnasoft.
:::
