---
sidebar_position: 200
---

# Why is Policy needed?

## Protect your development environment and CI from threat

The main purpose of Policy is to improve the security by preventing malicious tools from being executed.
`local` Registry and `github_content` Registry are useful, but they can also be abused. From khulnasoft v2, khulnasoft forbids non Standard Registries by default because almost users don't need them.

## Reduce the burden of code review keeping the security

Policy as Code reduces the burden of the code review and improves the security.

About Policy as Code, please see the document of Sentinel by Hashicorp.

https://docs.hashicorp.com/sentinel/concepts/policy-as-code

Policy works as guardrail and allows you to update `khulnasoft.yaml` freely unless `khulnasoft.yaml` violates Policy.
Especially, this is useful to automerge pull requests by Renovate safely.

If the code review is required to update `khulnasoft.yaml`,
the burden of the code review would increase in proportion to the frequency of pull requests.
Developers get tired of reviewing, reviews become messy, and problems are more likely to be overlooked.
If Policy allows you to accept the change of khulnasoft.yaml without review, the burden would be resolved.
Even if the code review is still required, developers don't have to check points reviewed by Policy.

## In case of Monorepo

If you manage many `khulnasoft.yaml` in Monorepo,
you have to check if all of them have no problem in terms of security.
A policy file is independent of `khulnasoft.yaml`, so you can use the same policy file for multiple `khulnasoft.yaml`.
A security team can manage a policy file, while product teams can manage `khulnasoft.yaml`.

For example, [tfaction](https://sulaiman-coder.github.io/tfaction/docs/), which is GitHub Actions Workflows for Terraform Monorepo, assumes that tools such as Terraform, tfsec, and tflint are managed per working directory.
This is useful to update tools per working directory gradually, but it is difficult for a team such security team or SRE team to review all `khulnasoft.yaml` in a large Monorepo.
So you have to leave the management of `khulnasoft.yaml` to each teams, but you also have to keep the governance and security.

Policy file is useful for it.
