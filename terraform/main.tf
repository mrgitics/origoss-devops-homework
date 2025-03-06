terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "hello-world-server-tf" {
  metadata {
    name = "hello-world-server-tf"
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "hello-world-server-tf"
      }
    }
    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_unavailable = 0
        max_surge       = 1
      }
    }
    template {
      metadata {
        labels = {
          app = "hello-world-server-tf"
        }
      }
      spec {
        container {
          name  = "hello-world-server-tf"
          image = "mrgitics/hello-world-server:v1.0"
          port {
            container_port = 8080
          }
          image_pull_policy = "IfNotPresent"
        }
      }
    }
  }
}

resource "kubernetes_service" "hello_world_service-tf" {
  metadata {
    name = "hello-world-service-tf"
  }
  spec {
    selector = {
      app = "hello-world-server-tf"
    }
    port {
      port        = 8080
      target_port = "8080"
      protocol    = "TCP"
    }
    type = "NodePort"
  }
}
