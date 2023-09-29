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
# Create Permanent Volumes (adjust paths and node name in nodeAffinity section in each pv-*.yaml file)
cd ./img-cluster-config
kubectl apply -f pv-datadir.yaml -f pv-importdir.yaml -f pv-logdir.yaml

# Check pv status:
kubectl get pv -n imaging

# Create Permanent Volumes Claims
cd ./img-cluster-config
kubectl apply -f pvc-datadir-neo4j-core-0.yaml -f pvc-importdir-neo4j-core-0.yaml -f pvc-logdir-neo4j-core-0.yaml

# Check pvc status:
kubectl get pvc -n imaging
```

Run below helm commands to install imaging
```
helm install imaging --namespace imaging --set version=2.18.0-beta2 .

#Get imaging pods and services status in kubernetes 
kubectl get pods -n imaging
kubectl get svc -n imaging

#Once neo4j pod status is Running, copy required csv files into neo4j data directory using provided shell script
./CopyNoe4jFiles.sh 

# Expose the deployment to access from outside
kubectl expose deployment server --name=loadbalancer --port=80 --target-port=80 --type=LoadBalancer -n imaging

#Update service image
helm upgrade imaging --namespace imaging --set serviceImage.tag=<some-version>  .

#Update etl image
helm upgrade imaging --namespace imaging --set etlImage.tag=<some-version> .

#Update neo4j image
helm upgrade imaging --namespace imaging --set neo4jImage.tag=<some-version> .

```
