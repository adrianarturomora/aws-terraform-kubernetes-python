# AWS Terraform Kubernetes Python Application

## 📌 Overview

This project demonstrates how to deploy a containerized Python application to **Amazon EKS** using **Terraform** and **Kubernetes**.

The infrastructure is provisioned entirely with Terraform, including a custom VPC, networking components, IAM roles, and an EKS cluster with managed worker nodes. The application is packaged with Docker, stored in **Amazon ECR**, and deployed to Kubernetes using standard Deployment and Service manifests.

The application exposes a simple HTTP API that checks whether the first and last digits of a number match. The logic is intentionally lightweight so the focus remains on cloud infrastructure, Kubernetes operations, and deployment workflows.

This project showcases hands-on experience with AWS, infrastructure as code, containerization, Kubernetes deployments, service exposure via load balancers, and safe teardown of cloud resources.

## 🏗️ Architecture

```
┌──────────────────────────────┐
│          Developer           │
│  (Docker, Terraform, kubectl)│
└───────────────┬──────────────┘
                │
                ▼
┌──────────────────────────────┐
│        Terraform (IaC)       │
│  - VPC                       │
│  - Subnets                   │
│  - IAM Roles                 │
│  - EKS Cluster               │
│  - Node Groups               │
└───────────────┬──────────────┘
                │
                ▼
┌──────────────────────────────┐
│     Amazon EKS (Control)     │
│  - Kubernetes API Server     │
│  - Cluster Networking        │
└───────────────┬──────────────┘
                │
                ▼
┌──────────────────────────────┐
│     Worker Nodes (EC2)       │
│  - kubelet                   │
│  - container runtime         │
└───────────────┬──────────────┘
                │
                ▼
┌──────────────────────────────┐
│    Kubernetes Deployment     │
│  - Python container (Flask)  │
│  - Replica management        │
│  - Health checks             │
└───────────────┬──────────────┘
                │
                ▼
┌──────────────────────────────┐
│   Kubernetes Service (LB)    │
│  - AWS Load Balancer         │
│  - External traffic routing  │
└──────────────────────────────┘

```

**Architecture Flow**
1. Terraform provisions all AWS infrastructure:
- VPC, subnets, IAM roles
- EKS cluster and worker node groups
2. Docker packages the Python application into a container image.
3. The container image is pushed to Amazon ECR.
4. Kubernetes (EKS) pulls the image and runs it as pods via a Deployment.
5. A Kubernetes Service (LoadBalancer) exposes the application externally using an AWS ELB.
6. Traffic flows:
```
Internet → AWS Load Balancer → Kubernetes Service → Pods → Python App
```

## 🧰 Tech Stack

- **Cloud**: AWS (EKS, EC2, VPC, IAM, ECR, ELB)
- **Infrastructure as Code**: Terraform
- **Containerization**: Docker
- **Orchestration**: Kubernetes
- **Backend**: Python (Flask)
- **CI/CD (Manual)**: Docker build → ECR → kubectl apply
- **OS**: Linux

## ⚙️ Application Functionality

The application exposes a REST API that checks whether the first digit
of a number matches the last digit.

### Endpoints
- `GET /health` → Health check
- `GET /check?x=121` → Returns validation result

### Example Response:
```json
{
  "number": 121,
  "first_equals_last": true
}
```

## 🚀 Deployment Flow

1. Python application is containerized using Docker
2. Docker image is pushed to Amazon ECR
3. Terraform provisions AWS infrastructure (VPC + EKS)
4. Kubernetes Deployment pulls image from ECR
5. Kubernetes Service exposes the app via AWS Load Balancer
6. Application is accessible publicly over HTTP

## 💡 What This Project Demonstrates

- AWS EKS deployment
- Infrastructure as Code using Terraform
- Kubernetes deployments and services
- Container lifecycle management
- Networking and load balancing in AWS
- Debugging EKS connectivity and IAM issues
- End-to-end ownership from code to cloud

## 📁 Repository Structure

```text
aws-terraform-kubernetes-python/
├── app/                # Python application
│   ├── app.py
│   └── requirements.txt
├── k8s/                # Kubernetes manifests
│   ├── deployment.yaml
│   └── service.yaml
├── terraform/          # Infrastructure as Code
│   ├── providers.tf
│   ├── vpc.tf
│   ├── eks.tf
│   └── variables.tf
└── README.md
```

## 🧾 Summary

This project demonstrates my ability to design, deploy, and operate a production-style cloud-native application on AWS using Infrastructure as Code and Kubernetes.

I provisioned an Amazon EKS cluster with Terraform, containerized a Python (Flask) application, stored images in Amazon ECR, and deployed the application to Kubernetes with proper health checks and external access via a LoadBalancer service.

The project highlights hands-on experience with:
- AWS infrastructure (EKS, ECR, VPC, IAM)
- Terraform for repeatable, auditable infrastructure
- Docker and container lifecycle management
- Kubernetes deployments, services, and health probes
- End-to-end deployment from source code to a live AWS endpoint

This repository reflects real-world DevOps and cloud engineering workflows rather than a simple local or tutorial-based setup.
