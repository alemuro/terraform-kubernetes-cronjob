variable "name" {
  type        = string
  description = "Name used to identify deployed container and all related resources."
}
variable "image" {
  type        = string
  description = "Image name and tag to deploy."
}
variable "schedule" {
  type        = string
  description = "Cron schedule expression for the job"
}
variable "paths" {
  type        = map(string)
  description = "Map of host paths to mount paths"
  default     = {}
}
variable "namespace" {
  type        = string
  description = "Kubernetes namespace where resources must be created."
  default     = "default"
}
variable "node_selector" {
  type        = map(string)
  description = "Node selector for the pod"
  default     = {}
}
variable "service_port" {
  type        = string
  description = "Port configured on the service side to receive requests (routed to the container port)."
  default     = "80"
}
variable "environment_variables" {
  type        = map(string)
  description = "Map of environment variables"
  default     = {}
}
variable "resources" {
  type = object({
    limits   = map(string)
    requests = map(string)
  })
  description = "Resource limits and requests for the container"
  default = {
    limits   = {}
    requests = {}
  }
}
variable "capabilities_add" {
  type        = list(string)
  description = "List of capabilities to add to the container"
  default     = []
}
variable "supplemental_groups" {
  type        = list(number)
  description = "List of supplemental groups for the container"
  default     = []
}
variable "image_pull_secret" {
  type        = string
  description = "Name of the image pull secret"
  default     = ""
}

variable "annotations" {
  type = object({
    ingress = optional(map(string), {})
    service = optional(map(string), {})
  })
  description = "Annotations added to some components. Only ingress and service supported at the moment."
  default = {
    ingress = {}
    service = {}
  }
}
variable "args" {
  type        = list(string)
  description = "Container arguments"
  default     = []
}

variable "privileged" {
  type        = bool
  description = "Run container in privileged mode"
  default     = false
}

variable "configmaps" {
  type        = map(string)
  description = "Map of configmap mount paths"
  default     = {}
}