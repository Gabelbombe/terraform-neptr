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
