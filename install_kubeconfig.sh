#!/bin/bash
cp -r ./kubespray/inventory/homelab-k8s/* ./ansible/
cp ./ansible/artifacts/admin.conf ~/.kube/config