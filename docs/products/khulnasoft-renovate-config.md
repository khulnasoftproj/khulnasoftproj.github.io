---
sidebar_position: 200
---

# khulnasoft-renovate-config

https://github.com/khulnasoftproj/khulnasoft-renovate-config

[Renovate Config Preset](https://docs.renovatebot.com/config-presets/) to update khulnasoft, khulnasoft-installer, packages, and registries.

[Example](https://github.com/khulnasoftproj/test-khulnasoft-renovate-config)

## Reference about Renovate

* [Renovate documentation](https://docs.renovatebot.com/)
* [Renovate Config Preset](https://docs.renovatebot.com/config-presets/)
  * How to use Preset
  * How to specify preset version and parameter
* [Custom Manager Support using Regex](https://docs.renovatebot.com/modules/manager/regex/)
  * This Preset updates tools with custom regular expression by Renovate Regex Manager

## List of Presets

* [default](https://github.com/khulnasoftproj/khulnasoft-renovate-config/blob/main/default.json)
* [file](https://github.com/khulnasoftproj/khulnasoft-renovate-config/blob/main/file.json)
  * khulnasoft.yaml. `fileMatch` is parameterized
* [installer-script](https://github.com/khulnasoftproj/khulnasoft-renovate-config/blob/main/installer-script.json)
  * the shell script [khulnasoftproj/khulnasoft-installer](https://github.com/khulnasoftproj/khulnasoft-installer). `fileMatch` is parameterized

## How to use

We recommend specifying the Preset version.

* :thumbsup: `"github>khulnasoftproj/khulnasoft-renovate-config#1.5.2"`
* :thumbsdown: `"github>khulnasoftproj/khulnasoft-renovate-config"`

### `default` Preset

```json
{
  "extends": [
    "github>khulnasoftproj/khulnasoft-renovate-config#1.5.2"
  ]
}
```

e.g.

```yaml
registries:
- type: standard
  ref: v3.128.0 # renovate: depName=khulnasoftproj/khulnasoft-registry

packages:
- name: open-policy-agent/conftest@v0.28.3
- name: GoogleCloudPlatform/terraformer/aws@0.8.18
```

The default preset updates GitHub Actions [khulnasoftproj/khulnasoft-installer](https://github.com/khulnasoftproj/khulnasoft-installer)'s `khulnasoft_version` in `.github` too.

```yaml
- uses: khulnasoftproj/khulnasoft-installer@v0.4.0
  with:
    khulnasoft_version: v1.35.0
```

### `file` Preset

You can specify the file path khulnasoft.yaml.
This is especially useful when [you split the list of packages](/docs/guides/split-config).

```json
{
  "extends": [
    "github>khulnasoftproj/khulnasoft-renovate-config:file#1.5.2(khulnasoft/.*\\.ya?ml)"
  ]
}
```

### `installer-script` Preset

The preset `installer-script` updates the shell script khulnasoft-installer and khulnasoft.
You have to pass fileMatch as parameter.

```json
{
  "extends": [
    "github>khulnasoftproj/khulnasoft-renovate-config:installer-script#1.5.2(scripts/.*\\.sh)"
  ]
}
```

```sh
curl -sSfL https://raw.githubusercontent.com/khulnasoftproj/khulnasoft-installer/v2.0.2/khulnasoft-installer | bash -s -- -v v1.25.0
```

:warning: To update khulnasoft, please don't add newlines.

:thumbsup:

```sh
curl -sSfL https://raw.githubusercontent.com/khulnasoftproj/khulnasoft-installer/v2.0.2/khulnasoft-installer | bash -s -- -v v1.25.0
```

:thumbsdown:

```sh
curl -sSfL https://raw.githubusercontent.com/khulnasoftproj/khulnasoft-installer/v2.0.2/khulnasoft-installer |
  bash -s -- -v v1.25.0 # khulnasoft isn't updated
```
