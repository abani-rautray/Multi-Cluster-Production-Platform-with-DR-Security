multi-cluster-platform/
├── infra/
│   ├── modules/
│   │   ├── vpc/
│   │   ├── eks/
│   │   ├── iam/
│   │   └── karpenter/
│   │
│   ├── eks-primary/
│   │   ├── backend.tf
│   │   ├── providers.tf
│   │   ├── variables.tf
│   │   ├── terraform.tfvars
│   │   ├── main.tf
│   │   └── outputs.tf
│   │
│   └── eks-dr/
│       ├── backend.tf
│       ├── providers.tf
│       ├── variables.tf
│       ├── terraform.tfvars
│       ├── main.tf
│       └── outputs.tf
│
├── gitops/
│   ├── argocd/
│   │   ├── install.yaml
│   │   └── app-of-apps.yaml
│   │
│   └── applications/
│       ├── sample-app.yaml
│       └── namespaces.yaml
│
├── clusters/
│   ├── prod-primary/
│   │   ├── namespaces.yaml
│   │   ├── apps.yaml
│   │   └── kustomization.yaml
        └── karpenter/
│           ├── nodepool.yaml
│           └── ec2nodeclass.yaml
│   │
│   └── prod-dr/
│       ├── namespaces.yaml
│       ├── apps.yaml
│       └── kustomization.yaml
        └── karpenter/
            ├── nodepool.yaml
            └── ec2nodeclass.yaml
│
├── dr/
│   ├── velero/
│   │   ├── install.yaml
│   │   ├── backup.yaml
│   │   └── restore.yaml
│   │
│   └── failover.md
│
├── observability/
│   ├── prometheus/
│   ├── grafana/
│   └── alerts/
│
└── README.md
