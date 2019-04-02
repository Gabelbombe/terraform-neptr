/**
# [Never Ending Pie Throwing Robot](https://www.youtube.com/watch?v=r4Uvm9kExU8)

Terraform configuration for lifecycle management of AWS instances.

Are you spending too much on your AWS instances every month? Do your developers create instances and forget to turn them off? Perhaps you struggle with identifying which person or system created AWS resources? Kill them with fire! j/k just shame them ;)

* ```hcl
* module "throws_pies" {
*   source      = "git@github.com:ehime/terraform-neptr?ref=v1.0.0"
* }
* ```

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
