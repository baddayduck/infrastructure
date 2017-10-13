variable "gce_project" {}
variable "gce_region" { default = "us-central1-a" }

provider "google" {
    credentials = "${file("account.json")}"
    project = "${var.gce_project}"
    region = "${var.gce_region}"
}

resource "google_container_cluster" "primary" {
    name = "cluster-1"
    zone = "${var.gce_region}"
    initial_node_count = 3

    master_auth {
        username = "user"
        password = "password"
    }

    node_config {
        machine_type = "n1-standard-1"
        oauth_scopes = [
            "compute-rw",
            "storage-ro",
            "logging-write",
            "monitoring"
        ]

        preemptible = true

    }
}