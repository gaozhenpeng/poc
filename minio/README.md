# minio
- https://hub.docker.com/r/minio/minio/
- https://docs.min.io/minio/baremetal/reference/minio-cli/minio-mc.html
- https://docs.min.io/docs/restic-with-minio.html
- https://artifacthub.io/packages/helm/minio/minio
- https://github.com/minio/minio
- https://github.com/minio/minio/tree/master/helm/minio
- https://github.com/minio/minio/blob/master/helm/minio/values.yaml
- https://docs.min.io/docs/deploy-minio-on-kubernetes.html
- https://github.com/minio/operator/blob/master/helm/minio-operator/values.yaml
- https://docs.min.io/minio/baremetal/lifecycle-management/lifecycle-management-overview.html
- https://docs.min.io/docs/minio-client-complete-guide.html
- https://restic.net/
- https://github.com/restic/restic/releases/
- https://restic.readthedocs.io/en/stable/

```bash
k3d cluster start poc
kubectl get pods -A

cd /vagrant/minio
helm repo add minio https://helm.min.io/
helm install minio minio/minio -f values.yml --wait

helm uninstall minio
k3d cluster stop poc

# compose
docker-compose up -d
docker-compose exec test sh
./mc config host add docker http://minio:9000 minio minio1234
./mc mb docker/test
./mc ls docker
./mc tree docker
echo "test" > test.txt
./mc cp test.txt docker/test
./mc du docker/test

# object expiration
./mc ilm add --expiry-days 60 docker/test

# backup to minio using restic
export AWS_ACCESS_KEY_ID=minio
export AWS_SECRET_ACCESS_KEY=minio1234
./restic -r s3:http://minio:9000/backup init
./restic -r s3:http://minio:9000/backup backup test.txt

# backup minio to local
```
