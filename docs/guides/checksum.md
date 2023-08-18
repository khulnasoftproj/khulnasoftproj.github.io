---
sidebar_position: 15
---

# Enable Checksum Verification

About Checksum Verification, please see also.

- [Reference](/docs/reference/security/checksum)
- [Configuration](/docs/reference/config/checksum)
- [Registry Configuration](/docs/reference/registry-config/checksum)
- [Usage > khulnasoft update-checksum](/docs/reference/usage#khulnasoft-update-checksum)

## Create a GitHub Repository

[Let's create a GitHub Repository for this tutorial](https://github.com/new).
You can remove the repository after this tutorial.

## Prepare GitHub Access Token

Please create a classic personal access token and add it to Repository Secrets.

- name: GH_TOKEN
- required permissions: `contents: write`

:::caution
GitHub Actions' token `GITHUB_TOKEN` is unavailable.
:::

:::info
~~Unfortunately, fine-grained personal access token is unavailable at the moment because it doesn't support GraphQL API.~~
~~https://github.com/cli/cli/issues/6680~~

2023-04-27 [fine-grained access token supports GraphQL API now.](https://github.blog/changelog/2023-04-27-graphql-improvements-for-fine-grained-pats-and-github-apps/)
:::

:::info
In this time we use a classic personal access token, but we recommend GitHub App or fine-grained access token in terms of security.
:::

## Create khulnasoft.yaml

```sh
khulnasoft init
khulnasoft g -i sulaiman-coder/tfcmt
```

## Enable Checksum Verification

By default, checksum verification is disabled.
Let's edit khulnasoft.yaml and enable Checksum Verification.

```yaml
---
checksum:
  enabled: true
registries:
- type: standard
  ref: v3.143.0 # renovate: depName=khulnasoftproj/khulnasoft-registry
packages:
- name: sulaiman-coder/tfcmt@v4.2.0
```

## Set up GitHub Actions Workflow

:::caution
For CircleCI Users, please use [circleci-orb-khulnasoft's update-checksum command](https://circleci.com/developer/orbs/orb/khulnasoftproj/khulnasoft#commands-update-checksum) instead.
:::

To create and update `khulnasoft-checksum.json` automatically, let's set up GitHub Actions.

```
mkdir -p .github/workflows
vi .github/workflows/update-khulnasoft-checksum.yaml
```

```yaml
name: update-khulnasoft-checksum
on:
  pull_request:
    paths:
      - khulnasoft.yaml
      - khulnasoft-checksums.json
jobs:
  update-khulnasoft-checksums:
    uses: khulnasoftproj/update-checksum-workflow/.github/workflows/update-checksum.yaml@f637ff2417a258303aeec16a7fa7a1a7a8bda020 # v0.1.3
    permissions:
      contents: read
    with:
      khulnasoft_version: v1.38.0
      prune: true
    secrets:
      gh_token: ${{secrets.GH_TOKEN}}
      # gh_app_id: ${{secrets.APP_ID}}
      # gh_app_private_key: ${{secrets.APP_PRIVATE_KEY}}
```

We use [update-checksum-action](https://github.com/khulnasoftproj/update-checksum-action).
This action depends on [int128/ghcp](https://github.com/int128/ghcp), so let's install it by khulnasoft.

```
khulnasoft g -i int128/ghcp
```

## Create a pull request

Commit `khulnasoft.yaml` and `.github/workflows/update-khulnasoft-checksum.yaml`.

```sh
git checkout -b ci/khulnasoft-checksum
git add khulnasoft.yaml .github/workflows/update-khulnasoft-checksum.yaml
git commit -m "ci: add khulnasoft.yaml and set up workflow"
git push origin ci/khulnasoft-checksum
```

Create a pull request. Then `khulnasoft-checksums.json` will be created by GitHub Actions.

![image](https://user-images.githubusercontent.com/13323303/224527388-720ce451-bdce-4055-9eed-ba0942615eea.png)

![image](https://user-images.githubusercontent.com/13323303/224527533-8fc150e2-55c1-4ca4-a9c7-f05544fdeccb.png)

## Change a package version

Let's change version.

```sh
sed -i "s/v4.2.0/v4.1.0/" khulnasoft.yaml
```

```diff
-- name: sulaiman-coder/tfcmt@v4.2.0
+- name: sulaiman-coder/tfcmt@v4.1.0
```

Push a commit.

```sh
git pull origin ci/khulnasoft-checksum
git add khulnasoft.yaml
git commit -m "chore: change tfcmt version"
git push origin "ci/khulnasoft-checksum"
```

Then `khulnasoft-checksums.json` is updated automatically.

![image](https://user-images.githubusercontent.com/13323303/224527976-4ddb1607-9958-4269-8882-3c0657e98a72.png)

![image](https://user-images.githubusercontent.com/13323303/224528023-72aba252-7507-47fa-87b2-dc08eb7f908b.png)

## See how Checksum Verification prevents tampering

Let's see how Checksum Verification prevents tampering.
It's bothersome to tamper assets actually, so in this time let's simulate the situation by tampering checksum in `khulnasoft-checksums.json`.

```sh
git pull origin ci/khulnasoft-checksum
vi khulnasoft-checksums.json
```

```diff
     {
       "id": "github_release/github.com/sulaiman-coder/tfcmt/v4.1.0/tfcmt_linux_amd64.tar.gz",
-      "checksum": "A8E55BEA1A5F94F9515FD9C5C3296D1874461BA1DBD158B3FC0ED6A0DB3B7D91",
+      "checksum": "A8E55BEA1A5F94F9515FD9C5C3296D1874461BA1DBD158B3FC0ED6A0DB3B7D92",
       "algorithm": "sha256"
     },
```

Add a GitHub Actions job that runs a tampered package.

```yaml
  test:
    runs-on: ubuntu-latest
    permissions:
      contents: read
    env:
      KHULNASOFT_LOG_COLOR: always
      KHULNASOFT_REQUIRE_CHECKSUM: "true"
    steps:
      - uses: actions/checkout@ac593985615ec2ede58e132d2e21d2b1cbd6127c # v3.3.0
      - uses: khulnasoftproj/khulnasoft-installer@61e2563dfe7674cbf74fe6ec212e444198a3bb00 # v2.0.2
        with:
          khulnasoft_version: v1.38.0
        env:
          GITHUB_TOKEN: ${{github.token}}
      - run: tfcmt -v
```

```sh
git add khulnasoft-checksums.json
git commit -m "chore: tamper khulnasoft-checksums.json"
git push origin "ci/khulnasoft-checksum"
```

Then `test` job would fail because the checksum is unmatched.

![image](https://user-images.githubusercontent.com/13323303/224528789-eeda95e7-73b9-46a3-95da-da954087e83b.png)

```
time="2023-03-12T06:36:05Z" level=fatal msg="khulnasoft failed" actual_checksum=A8E55BEA1A5F94F9515FD9C5C3296D1874461BA1DBD158B3FC0ED6A0DB3B7D91 khulnasoft_version=1.38.0 env=linux/amd64 error="checksum is invalid" exe_name=tfcmt expected_checksum=A8E55BEA1A5F94F9515FD9C5C3296D1874461BA1DBD158B3FC0ED6A0DB3B7D92 package=sulaiman-coder/tfcmt package_version=v4.1.0 program=khulnasoft
```
