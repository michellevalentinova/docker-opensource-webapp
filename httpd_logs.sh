#!/bin/bash

# requires jq for dev purposes

set -uxe
pod=$(kubectl get pods --selector=service=httpd --output json | jq -r '.items[0].metadata.name')
kubectl logs -f $pod
