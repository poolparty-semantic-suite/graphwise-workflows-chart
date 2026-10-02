# Graphwise Workflows Changelog

## Version 0.3.0

### New

- Added `N8N_RESTRICT_FILE_ACCESS_TO` as default property. It fixes the permissions over specific directory in the main
  container.
- Added default ephemeral volume for the `/tmp` directory for the runners container. It is required by some of the
  additional libraries installed in the container.

### Updated

- Updated `WEBHOOK_URL` to `N8N_WEBHOOK_URL`

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
