# Freestar Terraform modules (GCP)

Reusable Terraform modules for a **Google Cloud** baseline used with **Cloud Run**: networking, identity and IAM for the runtime service account, Secret Manager, and an external HTTP(S) load balancer in front of private Cloud Run.

Modules are intended to be consumed from this repository via **Git source** (Terraform does not allow variables in `module.source`).

## Requirements

- Terraform **>= 1.5**
- Google provider **>= 5** (`hashicorp/google`)
- Appropriate GCP APIs enabled for the resources you deploy (for example: Compute Engine, VPC Access, Secret Manager, Cloud Run, Artifact Registry—depending on your stack).

## Modules

| Module | Purpose |
|--------|---------|
| [`network`](./network) | Custom VPC, regional subnet, optional Serverless VPC Access connector. |
| [`security`](./security) | Dedicated Cloud Run **runtime** service account and optional project-level IAM (Artifact Registry reader by default; optional project-wide Secret Accessor). |
| [`secrets`](./secrets) | Secret Manager secret with a placeholder version; optional **per-secret** IAM for a runtime service account email. |
| [`load_balancer`](./load_balancer) | External Application Load Balancer (**EXTERNAL_MANAGED**) with a **serverless NEG** targeting an **existing Cloud Run (v2)** service; optional managed HTTPS; optional **public invoker** binding for LB-style access. |

## Usage

Pin a **tag or commit** in production (`?ref=`). Replace `YOUR_ORG` and adjust paths if your repository name differs.

```hcl
module "network" {
  source = "git::https://github.com/YOUR_ORG/freestar_modules.git//network?ref=main"

  project_id  = var.project_id
  region      = var.region
  name_prefix = var.name_prefix
}

module "security" {
  source = "git::https://github.com/YOUR_ORG/freestar_modules.git//security?ref=main"

  project_id  = var.project_id
  name_prefix = var.name_prefix
}

module "secrets" {
  source = "git::https://github.com/YOUR_ORG/freestar_modules.git//secrets?ref=main"

  project_id                    = var.project_id
  name_prefix                   = var.name_prefix
  runtime_service_account_email = module.security.runtime_service_account_email
}
```

The **`load_balancer`** module must target a Cloud Run service that **already exists** (the serverless NEG references it by name). Apply order is typically: network → security → secrets → deploy Cloud Run → load balancer.

```hcl
module "load_balancer" {
  source = "git::https://github.com/YOUR_ORG/freestar_modules.git//load_balancer?ref=main"

  project_id             = var.project_id
  region                 = var.region
  name_prefix            = var.name_prefix
  cloud_run_service_name = var.cloud_run_service_name
  ssl_domains            = var.ssl_domains # optional; empty = HTTP only on :80
}
```

## Related repositories

- **`freestar_app`** — Example application, Dockerfile, and CI that deploy Cloud Run and can run Terraform against these modules.

## Changelog

See [CHANGELOG.md](./CHANGELOG.md).
