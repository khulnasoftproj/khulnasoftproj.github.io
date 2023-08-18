---
sidebar_position: 20
---

# Policy as Code

`khulnasoft >= v2.3.0`

Policy is a feature to restrict the package installation and execution.
The main purpose of Policy is to improve the security by preventing malicious tools from being executed.

If you use only Standard Registry, you don't have to care of Policy.
From khulnasoft v2, khulnasoft allows only Standard Registry by default.
This means khulnasoft prevents malicious tools from being executed via malicious Registries by default.

If you use non Standard Registries, you have to create a Policy file to allow them.

## Getting Started

1. Set up the environment with Docker
1. Create `khulnasoft.yaml` and a local Registry `registry.yaml`
1. Try to use a local Registry and confirm the default Policy
1. Create a Git repository and khulnasoft-policy.yaml
1. Confirm the warning
1. Run `khulnasoft policy deny`
1. Run `khulnasoft policy allow`

--

1. Set up the environment with Docker

```
docker run --rm -ti alpine:3.17.0 sh
```

```
apk add curl bash sudo git
adduser -u 1000 -G wheel -D foo
visudo # Uncomment "%wheel ALL=(ALL) NOPASSWD: ALL"
su foo
mkdir ~/workspace
cd ~/workspace

export PATH="${KHULNASOFT_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/khulnasoftproj-khulnasoft}/bin:$PATH"
curl -sSfL -O https://raw.githubusercontent.com/khulnasoftproj/khulnasoft-installer/v2.1.1/khulnasoft-installer
echo "c2af02bdd15da6794f9c98db40332c804224930212f553a805425441f8331665  khulnasoft-installer" | sha256sum -c
chmod +x khulnasoft-installer
./khulnasoft-installer
```

2. Create `khulnasoft.yaml` and a local Registry `registry.yaml`

```
khulnasoft init
khulnasoft gr sulaiman-coder/ci-info > registry.yaml
vi khulnasoft.yaml
khulnasoft g -i cli/cli local,sulaiman-coder/ci-info
```

khulnasoft.yaml

```yaml
---
# khulnasoft - Declarative CLI Version Manager
# https://khulnasoftproj.github.io/
# checksum:
#   enabled: true
#   require_checksum: true
#   supported_envs:
#   - all
registries:
- type: standard
  ref: v3.150.0 # renovate: depName=khulnasoftproj/khulnasoft-registry
- name: local
  type: local
  path: registry.yaml
packages:
- name: cli/cli@v2.25.1
- name: sulaiman-coder/ci-info@v2.1.2
  registry: local
```

3. Try to use a local Registry and confirm the default Policy

```console
fe179d7889fd:~/workspace$ khulnasoft i
INFO[0000] download and unarchive the package            khulnasoft_version= env=linux/arm64 package_name=khulnasoft-proxy package_version=v1.1.4 program=khulnasoft registry=
INFO[0000] create a symbolic link                        khulnasoft_version= command=khulnasoft-proxy env=linux/arm64 package_name=khulnasoft-proxy package_version=v1.1.4 program=khulnasoft registry=
INFO[0000] create a symbolic link                        khulnasoft_version= command=gh env=linux/arm64 program=khulnasoft
INFO[0000] create a symbolic link                        khulnasoft_version= command=ci-info env=linux/arm64 program=khulnasoft
ERRO[0000] install the package                           khulnasoft_version= doc="https://khulnasoftproj.github.io/docs/reference/codes/002" env=linux/arm64 error="this package isn't allowed" package_name=sulaiman-coder/ci-info package_version=v2.1.2 program=khulnasoft registry=local
INFO[0000] download and unarchive the package            khulnasoft_version= env=linux/arm64 package_name=cli/cli package_version=v2.27.0 program=khulnasoft registry=standard
FATA[0002] khulnasoft failed                                   khulnasoft_version= env=linux/arm64 error="it failed to install some packages" program=khulnasoft
```

It fails to install `sulaiman-coder/ci-info` because the local Registry isn't allowed by default.

```
ERRO[0000] install the package                           khulnasoft_version= doc="https://khulnasoftproj.github.io/docs/reference/codes/002" env=linux/arm64 error="this package isn't allowed" package_name=sulaiman-coder/ci-info package_version=v2.1.2 program=khulnasoft registry=local
```

On the other hand, GitHub CLI is installed properly because Standard Registry is allowed by default.

```console
a82023e65a9e:~/workspace$ gh version
gh version 2.27.0 (2023-04-07)
https://github.com/cli/cli/releases/tag/v2.27.0
```

4. Create a Git repository and khulnasoft-policy.yaml

Let's create a Policy to allow the local Registry.

`.git` directory is required so that khulnasoft finds a Policy file.

```sh
git init # Create .git
khulnasoft policy init
vi khulnasoft-policy.yaml
```

khulnasoft-policy.yaml

```yaml
---
# khulnasoft Policy
# https://khulnasoftproj.github.io/
registries:
# Example
  - name: local
    type: local
    path: registry.yaml
# - name: khulnasoft-registry
#   type: github_content
#   repo_owner: khulnasoftproj
#   repo_name: khulnasoft-registry
#   ref: semver(">= 3.0.0") # ref is optional
#   path: registry.yaml
  - type: standard
    ref: semver(">= 3.0.0")
packages:
# Example
  - registry: local # allow all packages in the Registry
# - name: cli/cli # allow only a specific package. The default value of registry is "standard"
# - name: cli/cli
#   version: semver(">= 2.0.0") # version is optional
  - registry: standard
```

5. Confirm the warning

Run `khulnasoft i`, then khulnasoft outputs the warning and it fails to install `sulaiman-coder/ci-info`.

```console
fe179d7889fd:~/workspace$ khulnasoft i
WARN[0000] The policy file is ignored unless it is allowed by "khulnasoft policy allow" command.

$ khulnasoft policy allow "/home/foo/workspace/khulnasoft-policy.yaml"

If you want to keep ignoring the policy file without the warning, please run "khulnasoft policy deny" command.

$ khulnasoft policy deny "/home/foo/workspace/khulnasoft-policy.yaml"

   khulnasoft_version= doc="https://khulnasoftproj.github.io/docs/reference/codes/003" env=linux/arm64 policy_file=/home/foo/workspace/khulnasoft-policy.yaml program=khulnasoft
ERRO[0000] install the package                           khulnasoft_version= doc="https://khulnasoftproj.github.io/docs/reference/codes/002" env=linux/arm64 error="this package isn't allowed" package_name=sulaiman-coder/ci-info package_version=v2.1.2 program=khulnasoft registry=local
FATA[0000] khulnasoft failed                                   khulnasoft_version= env=linux/arm64 error="it failed to install some packages" program=khulnasoft
```

To resolve the warning, you have to check the Policy file and run either `khulnasoft policy allow` or `khulnasoft policy deny`.
If the Policy file is reliable, please run `khulnasoft policy allow`.

6. Run `khulnasoft policy deny`

Before running `khulnasoft policy allow`, let's try to run `khulnasoft policy deny`.

```
khulnasoft policy deny "/home/foo/workspace/khulnasoft-policy.yaml"
```

ci-info still failed but the warning is suppressed.

```console
2f4a758ab4ef:~/workspace$ ci-info --help
FATA[0000] khulnasoft failed                                   khulnasoft_version= doc="https://khulnasoftproj.github.io/docs/reference/codes/002" env=linux/arm64 error="this package isn't allowed" exe_name=ci-info package=sulaiman-coder/ci-info package_version=v2.1.2 program=khulnasoft
```

7. Run `khulnasoft policy allow`.

```
khulnasoft policy allow "/home/foo/workspace/khulnasoft-policy.yaml"
```

Then ci-info is available.

```console
2f4a758ab4ef:~/workspace$ ci-info --version
INFO[0000] download and unarchive the package            khulnasoft_version= env=linux/arm64 exe_name=ci-info package=sulaiman-coder/ci-info package_name=sulaiman-coder/ci-info package_version=v2.1.2 program=khulnasoft registry=local
ci-info version 2.1.2 (4a047e648dd0b9d0de1be356421d5d043c38d080)
```

If you modify the Policy file, you have to allow the change again.

```
echo "" >> khulnasoft-policy.yaml
```

```console
2f4a758ab4ef:~/workspace$ ci-info --version
WARN[0000] The policy file is changed. The policy file is ignored unless it is allowed by "khulnasoft policy allow" command.

$ khulnasoft policy allow "/home/foo/workspace/khulnasoft-policy.yaml"

If you want to keep ignoring the policy file without the warning, please run "khulnasoft policy deny" command.

$ khulnasoft policy deny "/home/foo/workspace/khulnasoft-policy.yaml"

   khulnasoft_version= doc="https://khulnasoftproj.github.io/docs/reference/codes/003" env=linux/arm64 exe_name=ci-info package=sulaiman-coder/ci-info package_version=v2.1.2 policy_file=/home/foo/workspace/khulnasoft-policy.yaml program=khulnasoft
FATA[0000] khulnasoft failed                                   khulnasoft_version= doc="https://khulnasoftproj.github.io/docs/reference/codes/002" env=linux/arm64 error="this package isn't allowed" exe_name=ci-info package=sulaiman-coder/ci-info package_version=v2.1.2 program=khulnasoft
```

Please run `khulnasoft policy allow` again, then ci-info is available.

```console
2f4a758ab4ef:~/workspace$ khulnasoft policy allow "/home/foo/workspace/khulnasoft-policy.yaml"
2f4a758ab4ef:~/workspace$ ci-info --version
ci-info version 2.1.2 (4a047e648dd0b9d0de1be356421d5d043c38d080)
```

Basically Policy files aren't changed so frequently, so it wouldn't be so bothersome to run `khulnasoft policy allow`.

## khulnasoft-installer's `policy_allow` input

khulnasoft >= `v2.3.0`, khulnasoft-installer >= `v2.1.0`

If the input `policy_allow` is set, khulnasoft-installer runs `khulnasoft policy allow` command.

```yaml
- uses: khulnasoftproj/khulnasoft-installer@v2.1.0
  with:
    khulnasoft_version: v2.3.0
    policy_allow: "true"
```

## update-checksum-workflow's `policy_allow` input

khulnasoft >= `v2.3.0`, [update-checksum-workflow](/docs/products/update-checksum-workflow) >= `v0.1.5`

If the input `policy_allow` is set, `khulnasoft policy allow` is run.

## :bulb: Best practice: Configure CODEOWENRS to protect Policy files

Basically you don't have to change Policy files so frequently and the change of Policy files should be reviewed carefully in terms of security.
So it is a good practice to protect Policy files by CODEOWNERS.

## See also

- [Reference](/docs/reference/security/policy-as-code)
