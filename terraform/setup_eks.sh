#!/bin/bash
set -e

echo "=== Verifying AWS credentials ==="
aws sts get-caller-identity

echo "=== Creating EKS cluster (this takes 15-20 minutes) ==="
eksctl create cluster --name=wanderlust \
                      --region=us-east-2 \
                      --version=1.30 \
                      --without-nodegroup

echo "=== Associating IAM OIDC Provider ==="
eksctl utils associate-iam-oidc-provider \
    --region us-east-2 \
    --cluster wanderlust \
    --approve

echo "=== Creating EKS Nodegroup (this takes another 5-10 minutes) ==="
eksctl create nodegroup --cluster=wanderlust \
                        --region=us-east-2 \
                        --name=wanderlust \
                        --node-type=t2.large \
                        --nodes=2 \
                        --nodes-min=2 \
                        --nodes-max=2 \
                        --node-volume-size=29 \
                        --ssh-access \
                        --ssh-public-key=terra-automate-key

echo "=== Verifying nodes ==="
kubectl get nodes

echo "=== EKS Cluster setup complete! ==="
