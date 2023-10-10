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

Create Imaging storage
```
# A sample implementation based on local Persistent Volumes is provided in ClusterStorage-local.yaml.
# Before using it, edit the file to:
#  -> specify the host name of the node on which you want to run Imaging (replace <imaging-host> for each Persistent Volume)
#  -> adjust the physical path of each Persistent Volume to match local folders on <imaging-host>
# Finally, apply the configuration:

kubectl ClusterStorage-local.yaml

# Check pv status:

kubectl get pv

```

Run below helm command to install imaging
```
helm install imaging --namespace imaging --set version=2.18.0 .

# Get imaging pods status in kubernetes:

kubectl get pods -n imaging

# Once neo4j's pod status is "Running", run below shell script:

./CopyCsvFiles.sh 

# Once all pods are "Running", access Imaging on http://<imaging-host>:30080
```
