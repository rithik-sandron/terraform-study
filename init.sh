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
    # enabling ta completion
    terraform -install-autocomplete



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
    gcloud compute zones list

#7. Basic TF commands
terraform fmt       # Format : format files
terraform init      # Init : initialize a directory and tf config files : downloads providers
terraform validate  # validate : validates config files nand check consistency and syntax 
terraform plan      # Plan : shows you what its gona do to achive desired state 
terraform apply     # Apply : applies on cloud or server and provisions infra
terraform destroy   # Destroy : destroys infra
terraform graph -type=plan | dot -Tpng > graph.png


#8. Learn learn GCP resources, types and their arguments here
https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance

#9. Variable file
<anything>.tf
# Assinging values to variables Variable 
terraform.tfvars or matching *.auto.tfvars


# GCP region list
https://cloud.google.com/compute/docs/regions-zones

# GCP APIs List
https://cloud.google.com/products?hl=en

# GCP API cheatsheet
https://googlecloudcheatsheet.withgoogle.com