# Option 1

## Prerequisites

- Docker
- Ansible
- Minikube
- Kubectl

## Ansible

Assuming you have ansible installed, you can run the following commands to install the required tools. after updating the inventory.ini file with the correct IP address.

run the following commands to install the required trivy. Trivy is a simple and comprehensive vulnerability scanner for containers and other artifacts. we will use it to scan the docker images.

### Install Trivy

```sh
cd ansible
ansible-playbook -i inventory.ini install-trivy-pb.yml
```

## Docker image

The project contains a Dockerfile that will be used to build the docker image. The image uses the official nginx image and copies the index.html file to the default nginx html directory. The image
is rootless and runs as a non-root user (`USER 1000`).

## Jenkins

The project contains a Jenkinsfile that will be used to build the docker image scan it and push it to the docker hub. The Jenkinsfile will also deploy the application to the minikube cluster.

**Note:** The manifests/deployment.yaml file contains is using the image name `nginx:latest for ease of testing. This should be updated to the correct image name built by Jenkins (soubai/web-app:latest).

## Run minikube

```sh
minikube start
```

#### Deploy the application

```sh
kubectl apply -f manifests/
```
