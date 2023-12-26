
resource "aws_ssm_maintenance_window" "linux" {
  name    = "Maintenance_Linux"
  schedule = "cron(0 2 ? * SUN *)"   # Fijar el horario para el mantenimiento 
  description   = "Maintenance Windows for Servers On Premises"
  duration = 3
  cutoff   = 1
  allow_unassociated_targets = true

  tags = {
    Environment = "ServidoresLinux"
  }
}

resource "aws_ssm_maintenance_window" "windows" {
  name    = "Maintenance_Window"
  schedule = "cron(0 2 ? * SUN *)"   # Fijar el horario para el mantenimiento
  description   = "Maintenance Windows for Servers On Premises"
  duration = 3
  cutoff   = 1
  allow_unassociated_targets = true

  tags = {
    Environment = "ServidoresWindows"
  }
}

resource "aws_ssm_maintenance_window_target" "target1" {
  window_id     = aws_ssm_maintenance_window.linux.id
  name          = "maintenance-linux-target"
  description   = "This is a maintenance linux target"
  resource_type = "INSTANCE"

   targets {
    key    = "tag:server"
    values = ["linux"]
  }
}

resource "aws_ssm_maintenance_window_target" "target2" {
  window_id     = aws_ssm_maintenance_window.windows.id
  name          = "maintenance-windows-target-2"
  description   = "This is a maintenance windows target"
  resource_type = "INSTANCE"

   targets {
    key    = "tag:server"
    values = ["windows"]
  }
}