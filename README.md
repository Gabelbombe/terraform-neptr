# The [Never Ending Pie Throwing Robot](https://www.youtube.com/watch?v=r4Uvm9kExU8)

Terraform configuration for lifecycle management of AWS instances.

![Lambda bot posting to Slack](./assets/guten_morgen.png)

Are you spending too much on your AWS instances every month? Do your developers create instances and forget to turn them off? Perhaps you struggle with identifying which person or system created AWS resources? Kill them with fire! j/k just shame them ;)

```hcl
module "throw_pies" {
  source      = "git@github.com:ehime/terraform-neptr?ref=v1.0.0"
}
```

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
```
main.tf - Main configuration file. REQUIRED
data_collectors.tf - Lambda functions for gathering instance data. REQUIRED
iam_roles.tf - Configures IAM role and policies for your Lambda functions. REQUIRED
notify_instance_usage.tf - sends reports about running instances.
notify_untagged.tf - sends reports about untagged instances and their key names.
instance_reaper.tf - Checks instance TTL tag, terminates instances that have expired.
untagged_janitor.tf - Cleans up untagged instances after a set number of days.
_files/ - Contains all of the lambda source code, zip files, and IAM template files.
```

See [example](example) for a complete example ....

## Documentation generation
Documentation should be modified within `main.tf` and generated using [terraform-docs](https://github.com/segmentio/terraform-docs):

```bash
terraform-docs md ./ |sed '$d' >| README.md
```

## License
GPL 3.0 Licensed. See [LICENSE](https://github.com/ehime/terraform-transitgateway/tree/master/LICENSE) for full details.


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| is_active | Determines whether scripts will actually stop and terminate instances or do a dry run instead. | string | `False` | no |
| mandatory_tags | Comma separated string mandatory tag values. | string | `TTL,owner` | no |
| reap_days | Days after launch after which untagged instances are terminated. | string | `90` | no |
| region | AWS Region | string | `sa-central-1` | no |
| slack_channel | Slack channel your bot will post messages to. | string | `#aws-hc-se-demos` | no |
| slack_hook_url | Slack incoming webhook URL, get this from the slack management page. | string | `https://hooks.slack.com/services/REPLACE/WITH/YOUR_WEBHOOK_URL` | no |
| sleep_days | Days after launch after which untagged instances are stopped. | string | `14` | no |
