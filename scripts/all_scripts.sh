
 gcloud artifacts repositories delete spn-art \
    --location=us-central1 \
    --project=spn-run

 gcloud artifacts repositories list --project=spn-run

terraform state rm module.workload_identity_pool.google_iam_workload_identity_pool.github_pool




https://stackoverflow.com/questions/76352037/error-400-request-contains-an-invalid-argument-while-creating-google-cloudbuild


# all workload identity pools
gcloud iam workload-identity-pools list --project=cog-run-lab
gcloud iam workload-identity-pools list --location="global"
 projects/146758086101/locations/global/workloadIdentityPools/wip-146758086101


terraform state list


# active project
gcloud config set project cog-run-lab
# check billing - billing Menu > Billing> Billing Account

# update secrete value


gcloud projects add-iam-policy-binding cog-run-lab \
    --member="serviceAccount:146758086101@cloudbuild.gserviceaccount.com" \
    --role="roles/secretmanager.secretAccessor"




# check identity pool
gcloud iam workload-identity-pools list --location="global"


gcloud secrets versions access latest --secret=db_password
echo -n "NEW_SECRET_VALUE" | gcloud secrets versions add <SECRET_NAME> --data-file=-
echo -n "my-updated-password" | gcloud secrets versions add db-password --data-file=-

gcloud secrets versions list db-password
gcloud secrets versions access latest --secret=db-password


gcloud iam service-accounts list

gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
  --member="serviceAccount:SERVICE_ACCOUNT_EMAIL" \
  --role="roles/cloudsql.client"

# directory ~/cloudshell_open/python-docs-samples/cloud-sql/mysql/sqlalchemy
gcloud builds submit --tag gcr.io/sky-cloud-run/run-sql


gcloud run deploy run-sql --image gcr.io/YOUR_PROJECT_ID/run-sql \
  --add-cloudsql-instances INSTANCE_CONNECTION_NAME \
  --set-env-vars INSTANCE_UNIX_SOCKET="/cloudsql/INSTANCE_CONNECTION_NAME" \
  --set-env-vars INSTANCE_CONNECTION_NAME="INSTANCE_CONNECTION_NAME" \
  --set-env-vars DB_NAME="quickstart-db" \
  --set-env-vars DB_USER="quickstart-user" \
  --set-env-vars DB_PASS="DB_PASS"

  gcloud run deploy run-sql --image gcr.io/sky-cloud-run/run-sql \
  --add-cloudsql-instances sky-cloud-run:us-central1:sky-sql \
  --set-env-vars INSTANCE_UNIX_SOCKET="/cloudsql/sky-cloud-run:us-central1:sky-sql" \
  --set-env-vars INSTANCE_CONNECTION_NAME="sky-cloud-run:us-central1:sky-sql" \
  --set-env-vars DB_NAME="sky-db" \
  --set-env-vars DB_USER="db_user" \
  --set-env-vars DB_PASS="db_password"