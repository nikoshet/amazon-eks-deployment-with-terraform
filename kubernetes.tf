resource "kubernetes_deployment" "webserver_deployment" {
  metadata {
    name = "terraform-example-webserver"
    labels = {
      app = "ExampleWebserver"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "ExampleWebserver"
      }
    }

    template {
      metadata {
        labels = {
          app = "ExampleWebserver"
        }
      }

      spec {
        container {
          image = "nginx:1.21.6"
          name  = "my-webserver"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "webserver_service" {
  metadata {
    name = "terraform-example-webserver"
  }
  spec {
    selector = {
      app = kubernetes_deployment.webserver_deployment.metadata.0.labels.app
    }
    port {
      port        = 80 #8080
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

