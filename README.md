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

Below command will create config map for all the required csv files

```
kubectl create configmap defaultcsvs --from-file=tools/csv -n imaging
```

Run below helm commands to install imaging

```
helm install imaging --namespace imaging --set version=2.16.0-beta4 .


#Update service image
helm upgrade imaging --namespace imaging --set serviceImage.tag=<some-version>  .

#Update etl image
helm upgrade imaging --namespace imaging --set etlImage.tag=<some-version> .

#Update neo4j image
helm upgrade imaging --namespace imaging --set neo4jImage.tag=<some-version> .

#Get pods and service in kubernetes
kubectl get pods -n imaging

kubectl get svc -n imaging

# expose the deployment to access from outside
kubectl expose deployment server --name=loadbalancer --port=80 --target-port=80 --type=LoadBalancer -n imaging


```
