resource "kubernetes_deployment" "wfm_ui" {
  metadata {
    name = "${local.k8s_recource_name_prefix}-ui"
    labels = {
      app = "${local.k8s_recource_name_prefix}-ui"
    }
  }

  spec {
    replicas = var.ui_replica_count[terraform.workspace]
    selector {
      match_labels = {
        app = "${local.k8s_recource_name_prefix}-ui"
      }
    }

    template {
      metadata {
        labels = {
          app = "${local.k8s_recource_name_prefix}-ui"
        }
      }

      spec {
        container {
          image = "registry.cargoclix.com/wfm/ui-front/${terraform.workspace}:latest"
          name  = "${local.k8s_recource_name_prefix}-ui"
          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = var.ui_pod_cpu_limit[terraform.workspace]
              memory = var.ui_pod_memory_limit[terraform.workspace]
            }
            requests = {
              cpu    = var.ui_pod_cpu_limit[terraform.workspace] / 10
              memory = var.ui_pod_memory_limit[terraform.workspace] / 2
            }
          }
        }

        image_pull_secrets {
          name = "ccxreg"
        }
      }
    }
  }
  wait_for_rollout = false
}

resource "kubernetes_service" "wfm_ui" {
  metadata {
    name = "${local.k8s_recource_name_prefix}-ui"
  }
  spec {
    selector = {
      app = "${local.k8s_recource_name_prefix}-ui"
    }
    port {
      port = 80
      #target_port = 80
    }

  }
}
