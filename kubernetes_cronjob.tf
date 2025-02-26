resource "kubernetes_cron_job_v1" "main" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }

  spec {
    schedule                      = var.schedule
    timezone                      = "Europe/Madrid"
    concurrency_policy            = "Forbid"
    failed_jobs_history_limit     = 1
    successful_jobs_history_limit = 1

    job_template {
      metadata {
        name = var.name
      }
      spec {
        template {
          metadata {}
          spec {
            container {
              name  = var.name
              image = var.image
              args  = var.args

              dynamic "env" {
                for_each = var.environment_variables
                content {
                  name  = env.key
                  value = env.value
                }
              }

              // Host path volumes
              dynamic "volume_mount" {
                for_each = var.paths
                content {
                  name       = lower("${var.name}-data-${replace(volume_mount.key, "/", "-")}")
                  mount_path = volume_mount.value
                }
              }

              // Configmap
              dynamic "volume_mount" {
                for_each = var.configmaps
                iterator = configmap
                content {
                  name       = "config"
                  mount_path = configmap.key
                  sub_path   = replace(trimprefix(configmap.key, "/"), "/", "-")
                  read_only  = true
                }
              }

              resources {
                limits   = var.resources.limits
                requests = var.resources.requests
              }

              security_context {
                privileged = var.privileged
                dynamic "capabilities" {
                  for_each = length(var.capabilities_add) > 0 ? [1] : []
                  content {
                    add = var.capabilities_add
                  }
                }
              }
            }

            // Host path volumes
            dynamic "volume" {
              for_each = var.paths
              content {
                name = lower("${var.name}-data-${replace(volume.key, "/", "-")}")
                host_path {
                  path = volume.key
                }
              }
            }

            // Configmaps
            dynamic "volume" {
              for_each = length(var.configmaps) > 0 ? [1] : []
              content {
                name = "config"
                config_map {
                  name = kubernetes_config_map_v1.configmap[0].metadata[0].name
                }
              }
            }

            node_selector  = var.node_selector
            restart_policy = "Never" # Important for CronJobs

            dynamic "security_context" {
              for_each = length(var.supplemental_groups) > 0 ? [1] : []
              content {
                supplemental_groups = var.supplemental_groups
              }
            }

            dynamic "image_pull_secrets" {
              for_each = var.image_pull_secret != "" ? [1] : []
              content {
                name = var.image_pull_secret
              }
            }
          }
        }
      }
    }
  }
} 