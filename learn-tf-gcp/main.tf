terraform {
  required_providers {
    google = {
      # rxegistry.terraform.io/hashicorp/google
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

# local Exec
# remote VM Exec
# file exec (copy files)
# Triggers
resource "null_resource" "create_file" {
  provisioner "local-exec" {
    command = "echo 'this is my first test' > foobar"
  }
}

resource "null_resource" "remote_example" {
  provisioner "remote-exec" {
    inline = [
      "echo Hello from remote!",
      "sudo apt-get update"
    ]
  }

  connection {
    type     = "ssh"
    host     = "var.remote_host"
  }
}
