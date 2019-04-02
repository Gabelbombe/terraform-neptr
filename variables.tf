variable "region" {
  description = "AWS Region"
  type        = "string"
  default     = "sa-central-1"
}

# Set your Slack Webhook URL here.  For extra security you can use AWS KMS to
# encrypt this data in the AWS console.
variable "slack_hook_url" {
  description = "Slack incoming webhook URL, get this from the slack management page."
  type        = "string"
  default     = "https://hooks.slack.com/services/REPLACE/WITH/YOUR_WEBHOOK_URL"
}

variable "slack_channel" {
  description = "Slack channel your bot will post messages to."
  type        = "string"
  default     = "#aws-hc-se-demos"
}

variable "mandatory_tags" {
  description = "Comma separated string mandatory tag values."
  type        = "string"
  default     = "TTL,owner"
}

variable "sleep_days" {
  description = "Days after launch after which untagged instances are stopped."
  type        = "string"
  default     = "14"
}

variable "reap_days" {
  description = "Days after launch after which untagged instances are terminated."
  type        = "string"
  default     = "90"
}

variable "is_active" {
  description = "Determines whether scripts will actually stop and terminate instances or do a dry run instead."
  type        = "string"
  default     = "False"
}
