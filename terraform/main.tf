terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {}

# Create a custom network for the VPS container
resource "docker_network" "vps_network" {
  name = "vps_network"
}

# Build a custom image with SSH support
resource "docker_image" "vps_image" {
  name = "vps-ssh"
  build {
    context = "./docker-context"
    dockerfile = "Dockerfile"
  }
}

# Create the VPS-like container
resource "docker_container" "vps" {
  name  = "user-vps"
  image = docker_image.vps_image.name
  restart = "always"

  networks_advanced {
    name = docker_network.vps_network.name
  }

  ports {
    internal = 22
    external = 2222
  }

  # Start SSH daemon in foreground
  command = ["/usr/sbin/sshd", "-D"]
}