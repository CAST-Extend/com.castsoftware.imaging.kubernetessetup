# CAST Imaging System

Cast Imaging provides MRI-like visibility into the most complex software systems. Imaging System intelligently organizes complex applications into logical application layers. Save time and money analyzing and mapping complex software and shorten the learning curve for new developers. Break down monolithic applications, visualize future designs and plan migrations from existing designs. Make architectural visibility accessible and scalable across the organization.

## Pre-requisites

- Kubernetes
- helm

## Setup

Make sure your kubernetes cluster is up and helm is installed on your system.

Create kubernetes namespace where you want to install imaging system

Below command will create namespace imaging
```
kubectl create ns imaging

```

Create required Permanent Volumes and Permanent Volumes Claims 
```
# Create Permanent Volumes:
# -> before proceeding, edit each pv-*.yaml file in img-cluster-config folder
#    to adjust volumes physical path and node name in the nodeAffinity section

kubectl apply -f pv-datadir.yaml -f pv-importdir.yaml -f pv-logdir.yaml

# Check pv status:

kubectl get pv -n imaging

# Create Permanent Volumes Claims:

kubectl apply -f pvc-datadir-neo4j-core-0.yaml -f pvc-importdir-neo4j-core-0.yaml -f pvc-logdir-neo4j-core-0.yaml

# Check pvc status:

kubectl get pvc -n imaging
```

Run below helm commands to install imaging
```
helm install imaging --namespace imaging --set version=2.18.0-beta2 .

# Get imaging pods status in kubernetes:

kubectl get pods -n imaging

# Once the status of the neo4j pod is "Running", run the shell script to copy the csv files:

./CopyNoe4jFiles.sh 

# Expose the deployment to access from outside:

kubectl expose deployment server --name=loadbalancer --port=80 --target-port=80 --type=LoadBalancer -n imaging
```
