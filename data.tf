# Fetch our own account id and region. Used in our IAM policy templates.
data "aws_caller_identity" "current" {}

# Template for our 'notify' lambda IAM policy
data "template_file" "iam_lambda_notify" {
  template = "${file("./_files/iam_lambda_notify.tpl")}"

  vars {
    account_id = "${data.aws_caller_identity.current.account_id}"
    region     = "${var.region}"
  }
}

# Template for our 'read_instances' lambda IAM policy
data "template_file" "iam_lambda_read_instances" {
  template = "${file("./_files/iam_lambda_read_instances.tpl")}"

  vars {
    account_id = "${data.aws_caller_identity.current.account_id}"
    region     = "${var.region}"
  }
}

# Template for our 'stop_and_terminate_instances' lambda IAM policy
data "template_file" "iam_lambda_stop_and_terminate_instances" {
  template = "${file("./_files/iam_lambda_stop_and_terminate_instances.tpl")}"

  vars {
    account_id = "${data.aws_caller_identity.current.account_id}"
    region     = "${var.region}"
  }
}

# Allows assume role for lambdas
data "aws_iam_policy_document" "iam_lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
