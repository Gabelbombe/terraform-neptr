# [Never Ending Pie Throwing Robot](https://www.youtube.com/watch?v=r4Uvm9kExU8)

Terraform configuration for lifecycle management of AWS instances.

![Lambda bot posting to Slack](./assets/guten_morgen.png)

Are you spending too much on your AWS instances every month? Do your developers create instances and forget to turn them off? Perhaps you struggle with identifying which person or system created AWS resources? Kill them with fire! j/k just shame them ;)

```hcl
module "throws_pies" {
  source      = "git@github.com:ehime/terraform-neptr?ref=v1.0.0"
}
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
