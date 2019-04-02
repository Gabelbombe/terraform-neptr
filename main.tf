/**
# The [Never Ending Pie Throwing Robot](https://www.youtube.com/watch?v=r4Uvm9kExU8)

Terraform configuration for lifecycle management of AWS instances.

![Lambda bot posting to Slack](./assets/guten_morgen.png)

Are you spending too much on your AWS instances every month? Do your developers create instances and forget to turn them off? Perhaps you struggle with identifying which person or system created AWS resources? Kill them with fire! j/k just shame them ;)

* ```hcl
* module "throw_pies" {
*   source      = "git@github.com:ehime/terraform-neptr?ref=v1.0.0"
* }
* ```

## Reference Material
  - [AWS Lambda and Slack Tutorial](https://api.slack.com/tutorials/aws-lambda)
  - [Slack Integration Blueprints for AWS Lambda](https://aws.amazon.com/blogs/aws/new-slack-integration-blueprints-for-aws-lambda/)
  - [Terraform `aws_lambda_function` resource](https://www.terraform.io/docs/providers/aws/r/lambda_function.html)

## Estimated Time to Complete
30-60 minutes

## Personas
Our target persona is anyone concerned with monitoring and keeping AWS instance costs under control. This may include managers, administrators, engineers or architects.

## Challenge
Many organizations struggle to maintain control over spending on AWS resources. Amazon Web Services makes it very easy to spin up new applicaiton workloads in the cloud, but the user is left to their own devices to clean up any unused or expired infrastructure. Users need an easy way to enforce tagging standards and shut down or terminate instances that are no longer required.

## Solution
This Terraform configuration deploys AWS Lambda functions that will implement the following:

  - Check for mandatory tags on AWS instances and notify via Slack if untagged instances are found.
  - Notify on how many of each instance type are currently running across all regions.
  - Shutdown untagged instances after **X** days.
  - Delete untagged instances after **Y** days.
  - Delete machines whose `TTL` (time to live) has expired.

### Directory Structure
A description of what each file does:
```bash
    main.tf - Main configuration file. REQUIRED
    data_collectors.tf - Lambda functions for gathering instance data. REQUIRED
    iam_roles.tf - Configures IAM role and policies for your Lambda functions. REQUIRED
    notify_instance_usage.tf - sends reports about running instances.
    notify_untagged.tf - sends reports about untagged instances and their key names.
    instance_reaper.tf - Checks instance TTL tag, terminates instances that have expired.
    untagged_janitor.tf - Cleans up untagged instances after a set number of days.
    _files/ - Contains all of the lambda source code, zip files, and IAM template files.
```

## Prerequisites
1. Admin level access to your AWS account via API. If admin access is not available you must have the ability to create, describe, and delete the following types of resources in AWS. Fine-grained configuration of IAM policies is beyond the scope of this guide. We will assume you have API keys and appropriate permissions that allow you to create the following resources using Terraform:
```bash
    aws\_cloudwatch\_event\_rule
    aws\_cloudwatch\_event\_target
    aws\_iam\_role
    aws\_iam\_role\_policy
    aws\_lambda\_function
    aws\_lambda\_permission
    aws\_kms\_alias
    aws\_kms\_key
```

2. Properly configured workstation or server for running Terraform commands. New to Terraform? Try our [Getting Started Guide](https://www.terraform.io/intro/getting-started/install.html)

3. An [incoming webhook integration](https://api.slack.com/incoming-webhooks) in your Slack account. If you want to receive notifications about instance usage and tags you'll need to be able to create a webhook or ask your administrator to help you create one.


See [example](example) for a complete example ....

## Documentation generation
Documentation should be modified within `main.tf` and generated using [terraform-docs](https://github.com/segmentio/terraform-docs):

```bash
terraform-docs md ./ |sed '$d' >| README.md
```

## License
GPL 3.0 Licensed. See [LICENSE](https://github.com/ehime/terraform-transitgateway/tree/master/LICENSE) for full details.
*/

provider "null" {}
provider "template" {}
