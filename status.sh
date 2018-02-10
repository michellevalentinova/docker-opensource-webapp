#!/bin/bash

set -ux
kubectl get replicationcontrollers
kubectl get services
kubectl describe service dow
kubectl describe service dow-mysqld
kubectl get pods --selector="app=dow" --output=wide
