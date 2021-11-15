# gcloud

```bash
# create gmail account
# activate 1 year free trial
# create project `kubtest`

# enable billing
# https://cloud.google.com/billing/docs/how-to/manage-billing-account

# create service account
# https://cloud.google.com/iam/docs/creating-managing-service-account-keys#iam-service-account-keys-create-gcloud

# registry service account role
# https://cloud.google.com/container-registry/docs/access-control

# create key
gcloud iam service-accounts keys create key.json
  --iam-account [SA-NAME]@[PROJECT-ID].iam.gserviceaccount.com

# set project and zone
docker run -it gcloud-alpine:latest sh -c "
    cd /google-cloud-sdk ;
    bin/gcloud config set project [PROJECT_ID] ;
    bin/gcloud config set compute/zone [ZONE]"
"
```
