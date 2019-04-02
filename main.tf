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

  2. Properly configured workstation or server for running Terraform commands. New to Terraform? Try the HashiCorp [Getting Started Guide](https://www.terraform.io/intro/getting-started/install.html)

  3. An [incoming webhook integration](https://api.slack.com/incoming-webhooks) in your Slack account. If you want to receive notifications about instance usage and tags you'll need to be able to create a webhook or ask your administrator to help you create one.

## TL;DR
Below are all of the commands you'll need to run to get these lambda scripts deployed in your account:
```bash
# Be sure to configure your Slack webhook and edit your variables.tf file first!
terraform init
terraform plan
terraform apply
```

## Steps
The following walkthrough describes in detail the steps required to enable the cleanup and 'reaper' scripts that are included in this repo.

### Step 1: Configure incoming Slack webhook
Set up your Slack incoming webhook: https://my.slack.com/services/new/incoming-webhook/. Feel free to give your new bot a unique name, icon and description. Make note of the Webhook URL. This is a specially coded URL that allows remote applications to post data into your Slack channels. Do not share this link publicly or commit it to your source code repo. Choose the channel you want your bot to post messages to.

![Slack Webhook Config Page](./assets/aws_bot.png)

### Step 2: Configure your variables
Edit the `variables.tf` file and choose which region you want to run your Lambda functions in. These functions can be run from any region and manage instances in any other region.

```hcl
variable "region" {
  description = "AWS Region"
  default     = "sa-central-1"
}

variable "slack_hook_url" {
  description = "Slack incoming webhook URL, get this from the slack management page."
  default = "https://hooks.slack.com/services/REPLACE/WITH/YOUR_WEBHOOK"
}
```

 * Set the `slack_hook_url` variable to the URL you generated in step #1.
 * Set any tags that you want to be considered mandatory in the `mandatory_tags` variable. This is a comma separated list, with no spaces between items.
 * Set the `reap_days` and `sleep_days` to your liking. These represent the number of days after launch that an untagged instance will be stopped and terminated respectively.
 * Leave the `is_active` variable set to 0 for testing. You must set this to 1 or True if you want to activate the scripts. 0 or False means reporting mode where nothing is actually stopped or terminated.
 * Save the `variables.tf` file.

### Step 3: Run Terraform Plan

#### CLI
 * [Terraform Plan Docs](https://www.terraform.io/docs/commands/plan.html)

#### Request

```bash
$ terraform plan
```

#### Response
```bash
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

<Output omitted for brevity>

Plan: 25 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

### Step 4: Run Terraform Apply

#### CLI
 * [Terraform Apply Docs](https://www.terraform.io/docs/commands/apply.html)

#### Request

```bash
$ terraform apply
```

#### Response
```bash
data.aws_caller_identity.current: Refreshing state...
data.template_file.iam_lambda_read_instances: Refreshing state...
data.template_file.iam_lambda_stop_and_terminate_instances: Refreshing state...
data.template_file.iam_lambda_notify: Refreshing state...

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

<Output omitted for brevity>

aws_lambda_function.getRunningInstances: Creation complete after 22s (ID: getRunningInstances)
aws_lambda_function.getUntaggedInstances: Creation complete after 22s (ID: getUntaggedInstances)
aws_lambda_function.getTaggedInstances: Creation complete after 23s (ID: getTaggedInstances)

Apply complete! Resources: 25 added, 0 changed, 0 destroyed.
```

### Step 4: Test your Lambda functions
Now you can test your new lambda functions. Use the test button at the top of the page to ensure they are working correctly. For your test event you can simply create a dummy event with the default JSON payload:

![Configure test event](./assets/dummy_event.png)

Check your slack channel to see the messages posted from your bot.

### Step 5: Adjust Schedule
By default the reporting lambdas are set to run once per day. You can customize the schedule by adjusting the `aws_cloudwatch_event_rule` resources. The schedule follows a Unix cron-style format: `cron(0 8 * * ? *)`. The instance_reaper will be most effective if it is run every hour.

### Step 6: Go live
_IMPORTANT_: If you want to actually stop and terminate instances in a live environment, you must uncomment/edit the code inside of `cleanUntaggedInstances.py` and `checkInstanceTTLs.py`. We have commented out the lines that do these actions so you can test before going live.  This is for your own safety and protection. In order to activate these scripts you must *both* uncomment those lines *and* set the is_active variable to True. You can uncomment the lines directly in the AWS Lambda editor, or make the changes locally and re-deploy your lambdas.

See below for the lines that handle `stop()` and `terminate()` actions.

```python
def sleep_instance(instance_id,region):
    ec2 = boto3.resource('ec2', region_name=region)
    """Stops instances that have gone beyond their TTL"""
    if str_to_bool(ISACTIVE) == True:
        # Uncomment to make this live!
        #ec2.instances.filter(InstanceIds=instance_id).stop()
        logger.info("I stopped "+instance_id+" in "+region)
    else:
        logger.info("I would have stopped "+instance_id+" in "+region)

def terminate_instance(instance_id,region):
    ec2 = boto3.resource('ec2', region_name=region)
    """Stops instances that have gone beyond their TTL"""
    if str_to_bool(ISACTIVE) == True:
        # Uncomment to make this live!
        #ec2.instances.filter(InstanceIds=instance_id).terminate()
        logger.info("I terminated "+instance_id+" in "+region)
    else:
        logger.info("I would have terminated "+instance_id+" in "+region)
```





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
