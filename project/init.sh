# Terraform commands
# init

# 1. Install google CLI
    # 1.1 download tar file
    # 1.2 
    ./google-cloud-sdk/install.sh
    ./google-cloud-sdk/bin/gcloud init


# 2. Install TF
    brew tap hashicorp/tap
    brew install hashicorp/tap/terraform
    brew upgrade hashicorp/tap/terraform
    brew install graphviz
    terraform -help
    terraform -install-autocomplete             # enabling ta completion


# 3. Create A Project in GCP
# 4. Enable Cloud Compute for that project
# 5  Writing Config
    mkdir learn-terraform-gcp
    cd learn-terraform-gcp
    touch main.tf


#6. Authenticate gcloud
    # creds -> /Users/azula/.config/gcloud/application_default_credentials.json 
    gcloud auth application-default login 
    gcloud config set project <project-ID>
    gcloud config get-value project # gives project that is set
    gcloud compute zones list

#7. Basic TF commands
terraform fmt       # Format : format files
terraform init      # Init : initialize a directory and tf config files : downloads providers
terraform validate  # validate : validates config files nand check consistency and syntax 
terraform plan      # Plan : shows you what its gona do to achive desired state 
terraform apply     # Apply : applies on cloud or server and provisions infra
terraform destroy   # Destroy : destroys infra
terraform graph -type=plan | dot -Tpng > graph.png

./google-cloud-sdk/bin/gcloud init
gcloud auth application-default login 
gcloud config set project newwork1
gcloud config get-value project
gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --region europe-west2-a
kubectl apply -f 4.kube.yaml
kubectl exec -it nginx -- /bin/bash
gcloud secrets list
gcloud secrets versions access latest --secret=secret
kubectl config set-context --current --namespace=default

kubectl create serviceaccount secret-access \
  --dry-run=client \
  -o yaml > kube.yaml

kubectl annotate serviceaccount default iam.gke.io/gcp-service-account=newwork1-sa@newwork1.iam.gserviceaccount.com

kubectl create role secret-access \
  --namespace=default \
  --verb=get,list,watch \
  --resource=secrets \
  --dry-run=client \
  -o yaml > kube.yaml


kubectl create rolebinding secret-access-bind \
  --namespace=default \
  --role=secret-access \
  --serviceaccount=default:default \
  --dry-run=client \
  -o yaml > kube.yaml

kubectl run py \
  --namespace=default \
  --image=gcr.io/newwork1/py:v2 \
  --dry-run=client \
  -o yaml > kube.yaml


python3 -m venv env
source env/bin/activate
pip3 install google-cloud-storage
pip3 install google-cloud-secret-manager
pip3 install google-cloud-resource-manager
gcloud components install gke-gcloud-auth-plugin
gcloud components install kubectl
gcloud auth configure-docker
export DOCKER=/usr/local/bin/docker
podman buildx build --platform linux/amd64 -t py:v2 .
podman build -t py:v2 .
podman tag py:v2 gcr.io/newwork1/py:v2
podman push gcr.io/newwork1/py:v2

podman inspect --format='{{.Os}}/{{.Architecture}}' py:v1
kubectl get secret secret -o jsonpath='{.data}' | base64 --decode
podman run --name py gcr.io/newwork1/py:v2

sudo touch usr/local/bin/docker ; sudo chmod 777 usr/local/bin/docker ; nano usr/local/bin/docker
#!/bin/bash
podman "$@"













#8. Learn learn GCP resources, types and their arguments here
https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance

#9. Variable file
<anything>.tf
# Assinging values to variables Variable 
terraform.tfvars or matching *.auto.tfvars

# checklist to setup an organisation
https://console.cloud.google.com/cloud-setup/foundations?hl=en&project=gke-test-432414
# GCP region list
https://cloud.google.com/compute/docs/regions-zones

# GCP APIs List
https://cloud.google.com/products?hl=en

# GCP API cheatsheet
https://googlecloudcheatsheet.withgoogle.com