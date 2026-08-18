# Graphwise Workflows Helm Chart

This Helm chart makes it easy to deploy Graphwise Workflows in your Kubernetes cluster.

## About Graphwise

<p align="center">
  <a href="https://graphwise.ai/">
      <img src="https://graphwise.ai/wp-content/uploads/2024/10/graphwise-logo-horizontal-slogan.svg" alt="Graphwise logo" title="Graphwise" height="75">
  </a>
</p>

Graphwise brings confidence to search, analytics, and AI. Our platform is built for enterprises where precision is a
must or complexity is high. We transform disparate data silos into a trusted enterprise knowledge graph, providing a
governed layer of context for consistent, reliable AI applications. At Graphwise, we turn enterprise data from a
liability into an asset. We build the “trusted semantic backbone” that connects disconnected data silos and integrates
your proprietary domain knowledge into your AI. This allows you to govern your AI, boost model accuracy, and drive a
positive ROI.

## Versioning

> [!IMPORTANT]
> This chart is at an early stage of development, and it might contain future breaking changes until finalized with
> version 1.0.0.

## Prerequisites

* Kubernetes v1.34+
* Helm v3.8+

For development and testing purposes, you can use [kind](https://kind.sigs.k8s.io/) to create a local Kubernetes
cluster. Check the example [kind.config.yaml](examples/kind/kind.config.yaml).

## Configuration

The chart is designed to be platform-agnostic and make use of the available default controllers in a Kubernetes cluster.
Make sure to check out the [values.yaml](values.yaml) file.

### Pull Secrets

The referenced container images are hosted on a private registry, so you need to create an image pull Secret:

```shell
kubectl create secret docker-registry graphwise-private \
        --docker-server=maven.ontotext.com \
        --docker-username=<username> \
        --docker-password=<password>
```

You can then use it in the `images.pullSecrets` field in [values.yaml](values.yaml):

```yaml
image:
  pullSecrets:
    - name: graphwise-private
```

### License

Graphwise Workflows relies on a https://n8n.io/ commercial license for certain features. If you have one, you can create
a Secret:

```shell
kubectl create secret generic graphwise-workflows-license --from-literal=LICENSE_KEY='XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
```

And use it by configuring the `license` section in [values.yaml](values.yaml):

```yaml
license:
  existingSecret: graphwise-workflows-license
  licenseKey: LICENSE_KEY
  tenantId: 1234567890 # Your unique tenant ID
```

### Database

To deploy the Graphwise Workflows chart, you need a PostgreSQL database already running. You can check
the [example](examples/postgres/README.md) on how to deploy a PostgreSQL database using the CNPG Operator.

### Encryption

The Graphgwise Workflows require a master encryption key to be configured in order to encrypt sensitive data.

```shell
kubectl create secret generic graphwise-workflows-encryption --from-literal=ENCRYPTION_KEY="XXXXXXXXXX"
```

Ater which you can refer to it in the `configuration.encryption` section in [values.yaml](values.yaml):

```yaml
configuration:
  encryption:
    existingSecret: graphwise-workflows-encryption
    secretKey: ENCRYPTION_KEY
```

## Installation

Once everything is ready and configured, you can install the Graphwise Workflows chart using the following command:

```shell
helm upgrade --install graphwise-workflows graphwise-workflows graphwise-workflows
```

## Uninstallation

To remove the Graphwise Workflows from your cluster, use the following command:

```shell
helm uninstall graphwise-workflows
```
