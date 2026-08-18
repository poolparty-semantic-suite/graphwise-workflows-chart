# Postgres Database Example

To deploy the Graphwise Workflows chart, you need a PostgreSQL database already running.
The [database.yaml](database.yaml) is a sample configuration for deploying a single replica PostgreSQL database using
the [CNPG Operator](https://cloudnative-pg.io/).

To install the database in the `default` namespace, execute:

```shell
kubectl apply -f database.yaml
```

After the database is ready, you can configure the chart to use it:

```yaml
configuration:
  postgresdb:
    host: graphwise-workflows-postgres-rw
    database: workflows
    credentials:
      existingSecret: graphwise-workflows-postgres-app
      usernameKey: username
      passwordKey: password
```
