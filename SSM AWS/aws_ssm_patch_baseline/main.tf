# Recurso para Amazon Linux
resource "aws_ssm_patch_baseline" "example_baseline_amazon_linux" {
  name             = "patch-test-amazon-linux"
  description      = "Patch baseline prueba para Amazon Linux"
  operating_system = "AMAZON_LINUX"

  approval_rule {
    approve_after_days = 7

    patch_filter {
      key    = "PRODUCT"
      values = ["AmazonLinux2012.03", "AmazonLinux2012.09", "AmazonLinux2013.03", "AmazonLinux2013.09", "AmazonLinux2014.03", "AmazonLinux2014.09", "AmazonLinux2015.03", "AmazonLinux2015.09", "AmazonLinux2016.03", "AmazonLinux2016.09", "AmazonLinux2017.03", "AmazonLinux2017.09", "AmazonLinux2018.03"]
    }

    patch_filter {
      key    = "CLASSIFICATION"
      values = ["Security"]
    }

    patch_filter {
      key    = "SEVERITY"
      values = ["Critical", "Important", "Medium", "Low"]
    }
  }

  tags = {
    Environment = "productforlinux"

    # Agrega otras etiquetas según tus necesidades
  }
}

# Recurso para Amazon Linux 2
resource "aws_ssm_patch_baseline" "example_baseline_amazon_linux_2" {
  name             = "patch-test-amazon-linux-2"
  description      = "Patch baseline prueba para Amazon Linux 2"
  operating_system = "AMAZON_LINUX_2"

  approval_rule {
    approve_after_days = 7

    patch_filter {
      key    = "PRODUCT"
      values = ["AmazonLinux2", "AmazonLinux2.0"]
    }

    patch_filter {
      key    = "CLASSIFICATION"
      values = ["Security"]
    }

    patch_filter {
      key    = "SEVERITY"
      values = ["Critical", "Important", "Medium", "Low"]
    }
  }

  tags = {
    Environment = "productforlinux2"

    # Agrega otras etiquetas según tus necesidades
  }
}

# Recurso para Windows
resource "aws_ssm_patch_baseline" "example_baseline_windows" {
  name             = "patch-test-amazon-windows"
  description      = "Patch baseline prueba para Windows"
  operating_system = "WINDOWS"

  approval_rule {
    approve_after_days = 7

    patch_filter {
      key    = "PRODUCT"
      values = ["Windows10", "WindowsServer2016", "WindowsServer2019", "WindowsServer2022"]
    }

    patch_filter {
      key    = "CLASSIFICATION"
      values = ["SecurityUpdates"]
    }

    patch_filter {
      key    = "MSRC_SEVERITY"
      values = ["Critical", "Important", "Moderate", "Low"]
    }
  }

  tags = {
    Environment = "productforwindows"

    # Agrega otras etiquetas según tus necesidades
  }
}
