data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "test_role" {
  name               = "AmazonEC2RunCommandRoleForManagedInstancesOnpremises" # En caso que el rol no exista, caso contrario usar otro nombre
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "test_attach" {
  role       = aws_iam_role.test_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMDirectoryServiceAccess"
}

resource "aws_iam_role_policy_attachment" "test_attach_directory" {
  role       = aws_iam_role.test_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_ssm_activation" "hybrid_activation" {
  name               = "ServersOnPremises"
  description        = "Servidores On Premises registrados en AWS SSM"
  iam_role           = aws_iam_role.test_role.id
  registration_limit = "5"
  depends_on         = [aws_iam_role_policy_attachment.test_attach]
}

# Luego de ejecutar el terraform apply

# Ejecutar:

# terraform state rm aws_ssm_activation.hybrid_activation

# terraform import aws_ssm_activation.hybrid_activation "Activation ID"



