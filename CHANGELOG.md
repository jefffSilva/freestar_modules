# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2026-04-18

### Added

- **`network`** module: custom VPC, regional subnet, optional Serverless VPC Access connector (`enable_vpc_connector`), configurable subnet and connector CIDRs.
- **`security`** module: Cloud Run runtime Google service account; optional project-level `roles/secretmanager.secretAccessor`; default additional role `roles/artifactregistry.reader`.
- **`secrets`** module: Secret Manager secret with placeholder version; optional `secretmanager.secretAccessor` IAM for a runtime service account (per secret).
- **`load_balancer`** module: global external IP, regional serverless NEG → Cloud Run, URL map, HTTP forwarding on port 80; optional managed SSL certificate and HTTPS forwarding when `ssl_domains` is set; optional `roles/run.invoker` for `allUsers` on the Cloud Run service for typical public traffic through the load balancer.

<!-- After the first Git tag, add compare/release links at the bottom of this file. -->
