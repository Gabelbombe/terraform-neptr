terraform {
  required_version = ">= 0.11.7"
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

module "throw_pies" {
  source         = "../"
  region         = "sa-central-1"
  slack_hook_url = "${var.slack_hook_url}"
}
