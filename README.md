🚀 Multi-Cluster EKS Production Platform with GitOps, DR & Observability
📌 Overview

This project demonstrates a production-grade Kubernetes platform on AWS EKS, designed with multi-cluster architecture, GitOps, autoscaling, disaster recovery, and observability.

The platform follows real-world DevOps / Platform Engineering practices used in production environments.

🧱 Architecture Summary

- Key design principles

- Infrastructure as Code (Terraform)

GitOps-driven deployments (ArgoCD)

Multi-cluster isolation (Primary + DR)

Cost-efficient autoscaling (Karpenter)

Disaster recovery using Kubernetes backups (Velero)

- Centralized monitoring and alerting

High-level Architecture

Developer → GitHub
              ↓
           ArgoCD (Primary)
              ↓
     ┌─────────────────────┐
     │                     │
EKS Primary           EKS DR
(prod-primary)        (prod-dr)
     │                     │
Karpenter           Karpenter
Prometheus           Prometheus
Grafana              Grafana
     │
  Velero → S3


📂 Repository Structure

multi-cluster-platform/
├── infra/                 # Terraform (AWS & EKS)
│   ├── modules/
│   ├── eks-primary/
│   └── eks-dr/
│
├── gitops/                # ArgoCD & GitOps control
│   ├── argocd/
│   └── applications/
│
├── clusters/              # Cluster-specific manifests
│   ├── prod-primary/
│   └── prod-dr/
│
├── dr/                    # Disaster Recovery (Velero)
│   └── velero/
│
├── observability/         # Monitoring & Alerts
│   ├── prometheus/
│   ├── grafana/
│   └── alerts/
│
└── README.md

🛠️ Technology Stack
Area	Tool
Cloud	AWS
Kubernetes	Amazon EKS
IaC	Terraform
GitOps	ArgoCD
Autoscaling	Karpenter
DR / Backup	Velero
Monitoring	Prometheus
Visualization	Grafana
🏗️ Infrastructure Design (Terraform)

Separate Terraform state files for Primary and DR clusters

Independent VPCs and CIDR ranges

IAM Roles for Service Accounts (IRSA)

Modular Terraform design for reusability

Why this matters

Independent lifecycle for each cluster

Safe DR testing

Minimal blast radius

🔄 GitOps Workflow

ArgoCD installed once in the Primary cluster

Uses App-of-Apps pattern

Git repository is the single source of truth

No manual kubectl apply for applications

Benefits

Auditability

Consistent deployments

Easy recovery during DR

⚙️ Autoscaling with Karpenter

Karpenter provisions nodes dynamically

Node behavior defined via:

EC2NodeClass

NodePool

Primary cluster supports higher capacity

DR cluster runs with reduced limits for cost efficiency

Why Karpenter

Faster scaling than traditional node groups

Automatic consolidation of unused nodes

Cost-optimized cluster operation

🔁 Disaster Recovery Strategy
Tool: Velero

Backs up Kubernetes namespaces to S3

Restores workloads into DR cluster when required

Manual, predictable failover process

Failover Flow

Primary cluster failure

Provision DR cluster (Terraform)

Install Velero in DR

Restore latest backup

Validate application & services

Update traffic routing (if needed)

RTO: ~15–30 minutes
RPO: Depends on backup frequency

📊 Observability
Monitoring

Prometheus collects cluster & pod metrics

Metrics retention optimized for cost

Visualization

Grafana dashboards for:

Cluster health

Pod stability

Node availability

Alerts

Pod crash looping

Node not ready

All observability components are deployed via GitOps.

🔐 Security Approach (Platform-Level)

This project focuses on baseline platform security, not security engineering.

IAM least privilege

IRSA (no static AWS credentials in pods)

Namespace isolation

Resource limits on workloads

GitOps-based change control

🧪 Validation & Testing

Application deployment via ArgoCD

Karpenter node provisioning on demand

Velero backup & restore testing

Prometheus alerts validation

🏆 What This Project Demonstrates

✅ Production-ready EKS design
✅ Multi-cluster architecture
✅ GitOps best practices
✅ Cost-aware autoscaling
✅ Disaster recovery planning
✅ Observability & alerting

🧠 Summary

“I built a production-grade, multi-cluster EKS platform using Terraform and GitOps. The system supports autoscaling with Karpenter, disaster recovery using Velero, and full observability with Prometheus and Grafana, while maintaining strong separation of concerns and cost efficiency.”

📌 Notes

DR cluster is intentionally smaller to reduce cost

Failover is manual but well-documented

Designed to reflect real-world DevOps practices

📜 License

MIT