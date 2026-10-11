variable "sentinel_alert_rule_machine_learning_behavior_analytics" {
  description = <<EOT
Map of sentinel_alert_rule_machine_learning_behavior_analytics, attributes below
Required:
    - alert_rule_template_guid
    - log_analytics_workspace_id
    - name
Optional:
    - enabled
EOT

  type = map(object({
    alert_rule_template_guid   = string
    log_analytics_workspace_id = string
    name                       = string
    enabled                    = optional(bool)
  }))
  validation {
    condition = alltrue([
      for k, v in var.sentinel_alert_rule_machine_learning_behavior_analytics : (
        length(v.name) > 0
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.sentinel_alert_rule_machine_learning_behavior_analytics : (
        can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", v.alert_rule_template_guid))
      )
    ])
    error_message = "must be a valid UUID"
  }
  # Note: 2 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

