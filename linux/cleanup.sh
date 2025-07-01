#!/bin/bash
set -e

echo "⚠️  Warning: This will destroy all Azure resources and remove local Terraform files."
echo "    Resources to be removed:"
echo "    - Security Groups"
echo "    - Key Pairs"
echo "    - Local .terraform files"
echo "    - Local .pem key files"
echo "    - Terraform state files"
echo "    - JSON files"

read -p "Are you sure you want to proceed? (y/N): " confirm

if [[ $confirm =~ ^([yY][eE][sS]|[yY])$ ]]; then
    if [ -d ".terraform" ]; then
        echo "🗑️  Destroying Azure resources..."
        terraform destroy -auto-approve
    else
        echo "ℹ️  No .terraform directory found, skipping resource destruction..."
    fi
    
    echo "🧹 Cleaning up local files..."
    rm -rf .terraform* *.pem terraform.tfstate* *.json
    
    echo "✅ Cleanup completed successfully!"
else
    echo "❌ Cleanup cancelled."
    exit 0
fi