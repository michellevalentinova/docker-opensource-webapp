#!/bin/bash

set -uxe
kubectl delete replicationcontrollers,services -l app=dow
