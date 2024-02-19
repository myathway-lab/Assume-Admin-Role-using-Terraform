resource "aws_iam_role" "AdministratorRole-Dev" {
  name     = "AdministratorRole-Dev"
  provider = aws.mt-lab-dev-mgmt
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "AWS" : var.Master-acc-id
          },
          "Condition" : {}
        }
    ] }
  )
  managed_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

resource "aws_iam_role" "AdministratorRole-Master" {
  name     = "AdministratorRole-Master"
  provider = aws.mt-lab-master-mgmt
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "AWS" : var.Master-acc-id
          },
          "Condition" : {}
        }
    ] }
  )
  managed_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}
