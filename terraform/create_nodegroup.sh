#!/bin/bash
set -e

echo "=== Creating EKS Nodegroup (m7i-flex.large) ==="
eksctl create nodegroup --cluster=wanderlust \
                        --region=us-east-2 \
                        --name=wanderlust \
                        --node-type=m7i-flex.large \
                        --nodes=2 \
                        --nodes-min=2 \
                        --nodes-max=2 \
                        --node-volume-size=20 \
                        --ssh-access \
                        --ssh-public-key=terra-automate-key

echo "=== Verifying nodes ==="
kubectl get nodes

echo "=== Nodegroup creation complete! ==="
