# These lambda functions return dictionaries of instances.
# Use them with other functions to take action on tagged, untagged
# or running instances.

resource "aws_lambda_function" "getUntaggedInstances" {
  filename         = "./_files/getUntaggedInstances.zip"
  function_name    = "getUntaggedInstances"
  role             = "${aws_iam_role.lambda_read_instances.arn}"
  handler          = "getUntaggedInstances.lambda_handler"
  source_code_hash = "${base64sha256(file("./_files/getUntaggedInstances.zip"))}"
  runtime          = "python3.6"
  timeout          = "120"
  description      = "Gathers a list of untagged or improperly tagged instances."

  environment {
    variables = {
      "REQTAGS" = "${var.mandatory_tags}"
    }
  }
}

resource "aws_lambda_function" "getTaggedInstances" {
  filename         = "./_files/getTaggedInstances.zip"
  function_name    = "getTaggedInstances"
  role             = "${aws_iam_role.lambda_read_instances.arn}"
  handler          = "getTaggedInstances.lambda_handler"
  source_code_hash = "${base64sha256(file("./_files/getTaggedInstances.zip"))}"
  runtime          = "python3.6"
  timeout          = "120"
  description      = "Gathers a list of correctly tagged instances."

  environment {
    variables = {
      "REQTAGS" = "${var.mandatory_tags}"
    }
  }
}

resource "aws_lambda_function" "getRunningInstances" {
  filename         = "./_files/getRunningInstances.zip"
  function_name    = "getRunningInstances"
  role             = "${aws_iam_role.lambda_read_instances.arn}"
  handler          = "getRunningInstances.lambda_handler"
  source_code_hash = "${base64sha256(file("./_files/getRunningInstances.zip"))}"
  runtime          = "python3.6"
  timeout          = "120"
  description      = "Gathers a list of running instances."
}
