
# My Homelab: A GitOps-Powered Kubernetes Playground

This repository contains the complete configuration for my personal homelab. The primary goal of this project is to build and manage a Kubernetes cluster that mimics a real-world production environment. It serves as a playground for me to experiment with cloud-native technologies, practice GitOps principles, and learn how to manage a production-like cluster.

## Philosophy

The core philosophy behind this project is to manage the entire cluster configuration using GitOps. I use FluxCD to automatically sync the cluster's state with the configuration defined in this repository. This approach provides several benefits:

*   **Declarative Configuration:** The entire cluster configuration is defined as code, making it easy to track changes, roll back to previous states, and rebuild the cluster from scratch.
*   **Automation:** FluxCD automatically applies any changes to the cluster, eliminating the need for manual intervention.
*   **Consistency:** The cluster's state is always consistent with the configuration in this repository.
*   **Security:** By using Git as the single source of truth, I can enforce access control and review all changes before they are applied to the cluster.

## Cluster Layout

The repository is structured to mimic the layout of a real-world Kubernetes cluster. The configuration is organized into three main directories:

*   `apps`: Contains the configuration for the applications running on the cluster.
*   `infrastructure`: Contains the configuration for the cluster's infrastructure services, such as storage, networking, and monitoring.
*   `clusters`: Contains the configuration for the Kubernetes cluster itself, including the control plane and worker nodes.

This structure allows me to manage the cluster's configuration in a modular and organized way. It also makes it easy to add new applications and services to the cluster.

## Services

| Service | Description | Icon |
| --- | --- | --- |
| **Glance** | A self-hosted dashboard that provides a quick overview of my homelab. | <img src="https://raw.githubusercontent.com/walkxcode/dashboard-icons/main/png/kubernetes-dashboard.png" width="32" height="32"> |
| **Thanos** | A highly available Prometheus setup with long-term storage capabilities. | <img src="https://raw.githubusercontent.com/walkxcode/dashboard-icons/main/png/thanos.png" width="32" height="32"> |
| **MetalLB** | A load-balancer implementation for bare metal Kubernetes clusters. | <img src="https://raw.githubusercontent.com/walkxcode/dashboard-icons/main/png/metallb.png" width="32" height="32"> |
| **Pi-hole** | A network-wide ad blocker that protects all my devices from unwanted content. | <img src="https://raw.githubusercontent.com/walkxcode/dashboard-icons/main/png/pi-hole.png" width="32" height="32"> |
| **Traefik** | A modern reverse proxy and load balancer that makes deploying microservices easy. | <img src="https://raw.githubusercontent.com/walkxcode/dashboard-icons/main/png/traefik.png" width="32" height="32"> |
| **Talos** | A modern OS for Kubernetes that is secure, immutable, and minimal. | <img src="https://raw.githubusercontent.com/walkxcode/dashboard-icons/main/png/talos.png" width="32" height="32"> |
| **Flux** | A tool that automatically ensures that the state of a cluster matches the config in git. | <img src="https://raw.githubusercontent.com/homarr-labs/dashboard-icons/refs/heads/main/png/flux-cd.png" width="32" height="32"> |
| **Monitoring**| A monitoring stack that includes Prometheus, Grafana, and Alertmanager. | <img src="https://raw.githubusercontent.com/walkxcode/dashboard-icons/main/png/grafana.png" width="32" height="32"> |

## GitOps with FluxCD

I use FluxCD to manage the cluster's state. The `flux-system` directory in the `clusters/thanos` directory contains the configuration for FluxCD. The `gotk-sync.yaml` file defines the synchronization between the cluster and this repository. Any changes pushed to the `main` branch of this repository will be automatically applied to the cluster.

## Future Plans

I plan to expand this cluster in the future by adding more nodes. I also plan to add more services to the cluster, such as:

*   A distributed storage solution, such as Ceph or Longhorn.
*   A continuous integration and delivery (CI/CD) pipeline.
*   A logging and monitoring solution, such as the ELK stack.

I am always looking for new and interesting technologies to experiment with. If you have any suggestions, please feel free to open an issue or a pull request.
