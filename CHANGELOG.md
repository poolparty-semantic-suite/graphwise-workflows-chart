# Graphwise Workflows Changelog

## Version 0.4.0

### New

- Added the `graphwiseOidc` configuration section for the OIDC (Keycloak) login hook bundled in the Workflows image. It is
  disabled by default; when disabled, the chart sets `GRAPHWISE_OIDC_ENABLED=false`. Users need the `workflow-access`
  role in Keycloak. The client secret comes from `graphwiseOidc.clientSecret.existingSecret`, or for development from
  `graphwiseOidc.clientSecret.secret`, in which case the chart creates the Secret.
- Added `hostAliases` for mapping hostnames that aren't resolvable from inside the cluster, e.g. the OIDC issuer's.

## Version 0.3.0

### New

- Added `N8N_RESTRICT_FILE_ACCESS_TO` as default property. It fixes the permissions over specific directory in the main
  container.
- Added default ephemeral volume for the `/tmp` directory for the runners container. It is required by some of the
  additional libraries installed in the container.
- Added `runners.persistence.shared.volumeName` to specify the volume name declaration

### Updated

- Updated `WEBHOOK_URL` to `N8N_WEBHOOK_URL`
- Updated to Graphwise Workflows version 1.0.0-RC1
- Updated to Graphwise Runners version 1.0.0-RC1
- Updated Task runners to use `.Chart.AppVersion` as their image's tag

## Version 0.2.0

### New

- Added a Job resource for bootstrapping the Workflows database.
- Added validation.yaml with custom validation rules based on values.yaml.
- Added NGINX Ingress examples in [examples/nginx-ingress](examples/nginx-ingress)
- Added support for templates in the image configurations

### Fixed

- Updated runners ports to avoid name clashing with the main container

## Version 0.1.0

This is the initial release of the Graphwise Workflows Helm chart.
