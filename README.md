# Docker Exercise

## Requirements
 - Google Cloud Platform account with billing enabled
 - Unix-like OS to run the shell scripts
 - kubectl installed + ~/.kube/config configured with access to a Kubernetes cluster OR Kubernetes cluster setup below
 - jq if connect to pods shell is desired
 - openssl and docker to generate a self-signed HTTPS certificate and key


## Create Kubernetes Cluster and Setup Authentication (Provider Setup)
 - Create new project at https://console.cloud.google.com/kubernetes/
 - Enable Kubernetes API for your project https://console.cloud.google.com/apis/api/container.googleapis.com/overview
 - Download gcloud SDK at https://cloud.google.com/sdk/
 - Decompress and install gcloud sdk (platform dependent)
 - Initialize the SDK (platform dependent)
   - Select to install kubectl as part of installation
 - Create a cluster for this test: gcloud container clusters create dow --zone XXXXXX (eg. europe-west1-b)
 - Download credentials for use by kubectl: gcloud container clusters get-credentials dow --zone XXXXXX (same as above)
 - Set default authentication: gcloud beta auth application-default login

## Create Project
 - Inside project directory
 - ./docker_build_image.sh docker/make-secret
 - ./docker_build_image.sh docker/dow
 - ./create.sh
 - ./generate_https_certificate.sh
 - Get IP address of LB: kubectl describe service dow | grep Ingress | cut -d ':' -f 2
 - If the above command doesn't print anything wait a few more minutes and execute again
 - Connect to LB:
   - curl http://IP

## Cleanup

### Project
 - Inside project directory
 - ./delete.sh

### Kubernetes Cluster and Authentication
 - gcloud container clusters delete dow
 - Delete project at https://console.cloud.google.com/kubernetes/
 - Remove gcloud SDK from local computer
 - Remove/cleanup ~/.kube/config
 - Remove permission grants for Google Cloud SDK and Google Auth Library at https://security.google.com/settings/security/permissions


## Changing Docker Prefix
In order to change the docker prefix (so the docker images can be generated using a different account), the following files need to be updated:
 - deployment.yaml
 - docker_build_image.sh
 - generate_https_certificate.sh
 - All the Dockerfile files under docker/


## Further Improvements
 - Use an external database as Docker IO isn't great
 - It's possible to also do SSL offloading on the LB instead of inside nginx on the pod (depending on LB used) and manage SSL certificates on the LB
 - Use a real HTTPS certificate
 - Annual HTTPS certificate renewal
 - Run httpd container as non-root
 - Logging
 - Metrics
 - Alerting
 - Kubernetes security http://blog.kubernetes.io/2016/08/security-best-practices-kubernetes-deployment.html
 - Improve MySQL password security
 - Docker security
 - Self-building make_secret container instead of a statically generated one in case make_secret.go changes
 - It would be great to have health checks on the Load balancers, not only on the pods
