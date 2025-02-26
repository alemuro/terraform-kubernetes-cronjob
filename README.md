<!-- BEGIN_TF_DOCS -->
# Terraform Module for creating a cronjob on a Kubernetes cluster

This module provides an easy way to deploy a cronjob on a Kubernetes cluster. It has been designed to allow cronjobs with only one container. See examples below.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image"></a> [image](#input\_image) | Image name and tag to deploy. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name used to identify deployed container and all related resources. | `string` | n/a | yes |
| <a name="input_schedule"></a> [schedule](#input\_schedule) | Cron schedule expression for the job | `string` | n/a | yes |
| <a name="input_annotations"></a> [annotations](#input\_annotations) | Annotations added to some components. Only ingress and service supported at the moment. | <pre>object({<br/>    ingress = optional(map(string), {})<br/>    service = optional(map(string), {})<br/>  })</pre> | <pre>{<br/>  "ingress": {},<br/>  "service": {}<br/>}</pre> | no |
| <a name="input_args"></a> [args](#input\_args) | Container arguments | `list(string)` | `[]` | no |
| <a name="input_capabilities_add"></a> [capabilities\_add](#input\_capabilities\_add) | List of capabilities to add to the container | `list(string)` | `[]` | no |
| <a name="input_configmaps"></a> [configmaps](#input\_configmaps) | Map of configmap mount paths | `map(string)` | `{}` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | Map of environment variables | `map(string)` | `{}` | no |
| <a name="input_image_pull_secret"></a> [image\_pull\_secret](#input\_image\_pull\_secret) | Name of the image pull secret | `string` | `""` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace where resources must be created. | `string` | `"default"` | no |
| <a name="input_node_selector"></a> [node\_selector](#input\_node\_selector) | Node selector for the pod | `map(string)` | `{}` | no |
| <a name="input_paths"></a> [paths](#input\_paths) | Map of host paths to mount paths | `map(string)` | `{}` | no |
| <a name="input_privileged"></a> [privileged](#input\_privileged) | Run container in privileged mode | `bool` | `false` | no |
| <a name="input_resources"></a> [resources](#input\_resources) | Resource limits and requests for the container | <pre>object({<br/>    limits   = map(string)<br/>    requests = map(string)<br/>  })</pre> | <pre>{<br/>  "limits": {},<br/>  "requests": {}<br/>}</pre> | no |
| <a name="input_service_port"></a> [service\_port](#input\_service\_port) | Port configured on the service side to receive requests (routed to the container port). | `string` | `"80"` | no |
| <a name="input_supplemental_groups"></a> [supplemental\_groups](#input\_supplemental\_groups) | List of supplemental groups for the container | `list(number)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->