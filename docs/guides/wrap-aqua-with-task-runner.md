---
sidebar_position: 800
---

# Wrap khulnasoft with task runner such as GNU Make

khulnasoft is [easy to use](/docs/#easy-to-use), but generally speaking it is not easy to introduce a new tool and let developers install it in a large team and organization.

By wrapping khulnasoft with a task runner such as [GNU Make](https://www.gnu.org/software/make/) and [Task](https://taskfile.dev/), you may be able to solve the issue.
If a task runner is already used in your project, it's easy to introduce khulnasoft.
By hiding the setup of khulnasoft (installing khulnasoft, adding `PATH`, and running `khulnasoft i [-l]`) from developers using task runner,
developers don't have to aware of khulnasoft.

## Example

:::caution
We aren't familiar with GNU Make and Task. So the example code of Makefile and Taskfile.yml may not be good.
And this example doesn't work in Windows.
Your contribution is welcome.
:::

https://github.com/sulaiman-coder/poc-khulnasoft-make

In this example, Terraform is managed by khulnasoft and developers can run `terraform` via GNU Make or Task without awareness of khulnasoft.

```console
$ make tf-init
```

<details>

```console
$ make tf-init
bash scripts/setup_khulnasoft.sh
khulnasoft-installer: OK
===> Installing khulnasoft v2.2.3 for bootstrapping...
===> Downloading https://github.com/khulnasoftproj/khulnasoft/releases/download/v2.2.3/khulnasoft_linux_arm64.tar.gz ...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100 5817k  100 5817k    0     0  5765k      0  0:00:01  0:00:01 --:--:-- 26.6M
===> Verifying checksum of khulnasoft v2.2.3 ...
khulnasoft_linux_arm64.tar.gz: OK
===> /tmp/tmp.hlehkM/khulnasoft update-khulnasoft
INFO[0000] download and unarchive the package            khulnasoft_version=2.2.3 env=linux/arm64 new_version=v2.6.0 package_name=khulnasoftproj/khulnasoft package_version=v2.6.0 program=khulnasoft registry=
INFO[0001] verify a package with slsa-verifier           khulnasoft_version=2.2.3 env=linux/arm64 new_version=v2.6.0 package_name=khulnasoftproj/khulnasoft package_version=v2.6.0 program=khulnasoft registry=
INFO[0001] download and unarchive the package            khulnasoft_version=2.2.3 env=linux/arm64 new_version=v2.6.0 package_name=slsa-framework/slsa-verifier package_version=v2.1.0 program=khulnasoft registry=
Verified signature against tlog entry index 20223381 at URL: https://rekor.sigstore.dev/api/v1/log/entries/24296fb24b8ad77a607c980c833eb73f84b6461d7932b893a0cc206bd8289cf74c92137efedf66c6
Verified build using builder https://github.com/slsa-framework/slsa-github-generator/.github/workflows/generator_generic_slsa3.yml@refs/tags/v1.5.0 at commit 903d205f6876aba423f753613ff01bbf97216c00
Verifying artifact /tmp/467478560: PASSED

PASSED: Verified SLSA provenance
INFO[0010] create a symbolic link                        khulnasoft_version=2.2.3 command=khulnasoft env=linux/arm64 new_version=v2.6.0 package_name=khulnasoftproj/khulnasoft package_version=v2.6.0 program=khulnasoft
khulnasoft version 2.6.0 (903d205f6876aba423f753613ff01bbf97216c00)
/workspace
INFO[0000] download and unarchive the package            khulnasoft_version=2.6.0 env=linux/arm64 package_name=khulnasoft-proxy package_version=v1.2.0 program=khulnasoft registry=
INFO[0000] create a symbolic link                        khulnasoft_version=2.6.0 command=khulnasoft-proxy env=linux/arm64 package_name=khulnasoft-proxy package_version=v1.2.0 program=khulnasoft registry=
INFO[0001] create a symbolic link                        khulnasoft_version=2.6.0 command=task env=linux/arm64 program=khulnasoft
INFO[0001] create a symbolic link                        khulnasoft_version=2.6.0 command=terraform env=linux/arm64 program=khulnasoft
terraform init
INFO[0000] download and unarchive the package            khulnasoft_version=2.6.0 env=linux/arm64 exe_name=terraform package=hashicorp/terraform package_name=hashicorp/terraform package_version=v1.4.6 program=khulnasoft registry=standard

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/null...
- Installing hashicorp/null v3.2.1...
- Installed hashicorp/null v3.2.1 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

</details>

```console
$ task tf-init
```

<details>

```console
$ task tf-init
task: [setup-khulnasoft] bash scripts/setup_khulnasoft.sh
task: [tf-init] terraform init

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/null from the dependency lock file
- Installing hashicorp/null v3.2.1...
- Installed hashicorp/null v3.2.1 (signed by HashiCorp)

Terraform has made some changes to the provider dependency selections recorded
in the .terraform.lock.hcl file. Review those changes and commit them to your
version control system if they represent changes you intended to make.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

</details>

Directory structure

```
Makefile or Taskfile.yml
scripts/
  setup_khulnasoft.sh
```

setup_khulnasoft.sh

```bash
#!/usr/bin/env bash

set -eu
set -o pipefail

if command -v khulnasoft > /dev/null 2>&1; then
  exit 0
fi

tempdir=$(mktemp -d)
cd "$tempdir"
curl -sSfL -O https://raw.githubusercontent.com/khulnasoftproj/khulnasoft-installer/v2.1.1/khulnasoft-installer
echo "c2af02bdd15da6794f9c98db40332c804224930212f553a805425441f8331665  khulnasoft-installer" | sha256sum -c
chmod +x khulnasoft-installer

./khulnasoft-installer
cd -

rm -R "$tempdir"

khulnasoft i -l
```

Makefile

```makefile
ifeq ($(KHULNASOFT_ROOT_DIR),)
ifeq ($(XDG_DATA_HOME),)
	KHULNASOFT_ROOT_DIR := $(HOME)/.local/share/khulnasoftproj-khulnasoft
else
	KHULNASOFT_ROOT_DIR := $(XDG_DATA_HOME)/khulnasoftproj-khulnasoft
endif
endif

PATH := $(KHULNASOFT_ROOT_DIR)/bin:$(PATH)

.PHONY: setup-khulnasoft
setup-khulnasoft:
	bash scripts/setup_khulnasoft.sh

.PHONY: tf-init
tf-init: setup-khulnasoft
	terraform init
```

Taskfile.yml

```yaml
version: '3'

vars:
  KHULNASOFT_ROOT_DIR:
    sh: echo "${KHULNASOFT_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/khulnasoftproj-khulnasoft}"

env:
  PATH: "{{.KHULNASOFT_ROOT_DIR}}/bin:{{.PATH}}"

tasks:
  tf-init:
    deps: [setup-khulnasoft]
    cmds:
      - terraform init

  setup-khulnasoft:
    cmds:
      - bash scripts/setup_khulnasoft.sh
```
