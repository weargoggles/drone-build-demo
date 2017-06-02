job "drone-build-demo" {
  datacenters = ["eu-west-1"]
  type        = "service"

  group "web" {
    count = 1

    task "web" {
      driver = "docker"

      config {
        image = "weargoggles/drone-build-demo:IMAGE_TAG"

        port_map {
          http = 8000
        }
      }

      resources {
        memory = 128

        network {
          mbits = 1
          port  "http"{}
        }
      }

      service {
        name = "drone-build-demo"

        tags = [
          "urlprefix-drone-build-demo.tuna.dabdev.net/",
        ]

        port = "http"

        check {
          name     = "tcp"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
