## PostgreSQL - reliable SQL database

### External access

By default external access to the PostgreSQL port isn't available. This is easily changed by applying the following YAML to your cluster with `kubectl apply -f postgresql-service.yaml` (or whatever you call the file containing the contents below):

```
apiVersion: v1
kind: Service
metadata:
  name: postgresql-service
spec:
  type: LoadBalancer
  ports:
    - port: 5432
      targetPort: 5432
      protocol: TCP
  selector:
    app: postgresql
```

This will open up http://DOMAIN_NAME:5432 to the whole world. You should lock this down in the [firewall](https://www.civo.com/account/firewalls) automatically created in Civo for your Kubernetes cluster. Locking down the firewall will only affect access from OUTSIDE of your Kubernetes cluster, access from your applications within Kubernetes will not be affected.

### Usage instruction

You can use this application from within your cluster by just using the hostname `postgresql` and can create databases and users using the admin access credentials above this message. For example, to create an application's database and user credentials and given that the `kubectx` and [Civo CLI](https://github.com/civo/cli) are installed, with a Civo Kubernetes cluster called `my-cluster-name`:

```
$ civo k3s config my-cluster-name --save
$ kubectx my-cluster-name
$ kubectl run tmp-shell --generator=run-pod/v1 --rm -i \
  --tty --image alpine -- /bin/sh

/ # apk update
/ # apk add postgresql-client
/ # psql -U ADMIN_USERNAME -h postgresql postgresdb
Password for user 12CNT2Eq6i:
psql (11.5)
Type "help" for help.

postgresdb=# CREATE DATABASE yourdbname;
postgresdb=# CREATE USER youruser WITH ENCRYPTED PASSWORD 'super-strong-password';
postgresdb=# GRANT ALL PRIVILEGES ON DATABASE yourdbname TO youruser;
```
