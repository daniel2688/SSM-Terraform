
resource "aws_ssm_maintenance_window" "linux" {
  name                   = "Maintenance_Linux_test"
  schedule               = "cron(0 2 ? * SUN *)"
  description            = "Maintenance Windows for Servers On Premises"
  duration               = 3
  cutoff                 = 1
  allow_unassociated_targets = false

  tags = {
    Environment = "ServersLinux"
  }
}

# Se crea los target para la ventana de mantenimiento:

resource "aws_ssm_maintenance_window_target" "target1" {
  window_id       = aws_ssm_maintenance_window.linux.id
  name            = "maintenance-linux-target"
  description     = "This is a maintenance linux target"
  resource_type   = "RESOURCE_GROUP"

  targets {
    key    = "resource-groups:Name"
    values = ["ResourceGroupLinux"]
  }
}

# Se crea la tarea en la ventana de mantenimiento:

resource "aws_ssm_maintenance_window_task" "example" {
  name                   = "TaskExecuteforLinux"
  description            = "This is a maintenance task for Linux servers"
  max_concurrency        = 2
  max_errors             = 1
  priority               = 1
  service_role_arn       = "arn:aws:iam::236609069548:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"
  task_arn               = "AWS-RunPatchBaseline"
  task_type              = "RUN_COMMAND"
  window_id              = aws_ssm_maintenance_window.linux.id


  # Cambiado a InstanceIds
  targets {
    key    = "InstanceIds"
    values = [aws_ssm_maintenance_window_target.target1.id]
  }

  task_invocation_parameters {
    run_command_parameters {
      document_version   = "$LATEST"
      timeout_seconds    = 600

      parameter {
        name   = "Operation"
        values = ["Install"]
      }

      parameter {
        name   = "BaselineTags"
        values = ["Environment=Productforlinux"]
      }
    }
  }
}

# La configuracion hace uso de tags para identificar el recurso


# Creacion de Resource Group por medio de tags

resource "aws_resourcegroups_group" "test" {
  name        = "ResourceGroupLinux"
  description = "Servidores On Premises registrados con SSM"
  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": [
    "AWS::SSM::ManagedInstance"
  ],
  "TagFilters": [
    {
      "Key": "server",
      "Values": ["linux"]
    }
  ]
}
JSON
  }
  tags = {
    product = "ServersLinux"

    // Agrega más etiquetas según sea necesario
  }
}