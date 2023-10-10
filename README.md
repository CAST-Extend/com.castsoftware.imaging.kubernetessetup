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

Create Permanent Volumes and Permanent Volumes Claims 
```
# Create Permanent Volumes:
#   A sample implementation based on local Persistent Volumes is provided in ClusterStorage-local.yaml.
#   Before using it, edit the file to:
#   -> specify the host name of the node on which you want to run Imaging (replace <imaging-host> on each Persistent Volume)
#   -> adjust the physical path of each Persistent Volume to match local folders
# Then apply the configuration:

kubectl ClusterStorage-local.yaml

# Check pv status:

kubectl get pv

```

Run below helm commands to install imaging (from root folder)
```
helm install imaging --namespace imaging --set version=2.18.0 .

# Get imaging pods status in kubernetes:

kubectl get pods -n imaging

# Wait until neo4j's pod status is "Running" and run below shell script to copy some required files:

./CopyCsvFiles.sh 

# Once all pods are "Running", access Imaging on http://mynodehostname:30080
```
