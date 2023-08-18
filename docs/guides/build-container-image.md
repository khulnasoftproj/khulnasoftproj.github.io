---
sidebar_position: 700
---

# Build Container (Docker) Image

When building a container (Docker) image, you may want to download and install tools from GitHub Releases or other sources.
In particular, if you run CI with CircleCI or Google Cloud Build, you may want to install tools for CI on the image.

Traditionally, you would use curl, tar, unzip, etc. to install these tools, but with khulnasoft, you can declaratively manage them.
You don't have to look up download URLs, formats, etc. yourself.
You can also use Renovate to automate updates.

khulnasoft.yaml

```yaml
---
# khulnasoft - Declarative CLI Version Manager
# https://khulnasoftproj.github.io/
registries:
- type: standard
  ref: v3.19.0 # renovate: depName=khulnasoftproj/khulnasoft-registry
packages:
- name: rhysd/actionlint@v1.6.15
- name: golangci/golangci-lint@v1.47.2
- name: reviewdog/reviewdog@v0.14.1
```

Dockerfile

```dockerfile
FROM alpine:3.16
RUN apk add curl
RUN curl -sSfL https://raw.githubusercontent.com/khulnasoftproj/khulnasoft-installer/v1.1.0/khulnasoft-installer | sh -s -- -i /usr/local/bin/khulnasoft -v v1.18.0
COPY khulnasoft.yaml /khulnasoft.yaml
RUN khulnasoft -c /khulnasoft.yaml i
ENV KHULNASOFT_GLOBAL_CONFIG=/khulnasoft.yaml
ENV PATH=/root/.local/share/khulnasoftproj-khulnasoft/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```

## Remove khulnasoft from Image

khulnasoft >= [v1.18.0](https://github.com/khulnasoftproj/khulnasoft/releases/tag/v1.18.0)

In the above Docker image, khulnasoft is installed and used internally to execute tools.
However, if you do not want to install anything extra in the Docker image, if you want to keep the image minimal, or if you do not want to switch tool versions with khulnasoft,
you can also remove khulnasoft using the Multistage Build and `khulnasoft cp` command.

Dockerfile

```dockerfile
FROM alpine:3.16 AS khulnasoft
RUN apk add curl
RUN curl -sSfL https://raw.githubusercontent.com/khulnasoftproj/khulnasoft-installer/v1.1.0/khulnasoft-installer | sh -s -- -i /usr/local/bin/khulnasoft -v v1.18.0
COPY khulnasoft.yaml /khulnasoft.yaml
RUN khulnasoft -c /khulnasoft.yaml cp -o /dist actionlint reviewdog

FROM alpine:3.16.1
RUN apk --no-cache add ca-certificates
COPY --from=khulnasoft /dist/* /usr/local/bin/
```

`khulnasoft cp` installs specified tools and copies executable files to the specified directory.
In the above example, actionlint and reviewdog are installed and copied under /dist.
Only executable files are installed in the final image.

## Notes of `khulnasoft cp`

There is a caveat to `khulnasoft cp`.
`khulnasoft cp` copies only executable files from packages.
Therefore, tools that do not work with a single file will not work properly even if they are copied by `khulnasoft cp`.
If the tool is a single binary written in Go, there is basically no problem, but if it is a shell script depending on another files in the same repository, it will not work properly.

For example, tfenv will not work correctly even if you copy it by `khulnasoft cp`.
You need to install those tools in a different way.
