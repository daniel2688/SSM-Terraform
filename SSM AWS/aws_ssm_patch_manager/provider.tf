
# Todo esta configuracion esta basado en tags asignados a cada configuracion que participa parpa la configuracion general:
# Proveedor Terraform:

terraform {
  required_version = "~> 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
