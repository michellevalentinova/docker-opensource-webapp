#!/bin/bash

set -uxe
kubectl delete pods -l app=dow
