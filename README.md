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
# A sample storage configuration is provided in ClusterStorage-local.yaml.
# IMPORTANT NOTE: this storage configuration is based on Persistent Volumes of type "local".
#                 As "local" Persistent Volumes are by nature attached to a specific node, Imaging pods
#                 will always be scheduled to run on the node where those Persistent Volumes reside.
#                 This is provided as an example and for testing purposes.
#                 Make sure to customize this configuration and use the type of Persistent Volume
#                 that is suitable for you.
# Edit this file before applying it:
#  -> specify the host name of the node on which the local Persistent Volumes will be created
#     (replace <imaging-host> in each 3 Persistent Volume spec)
#  -> adjust the physical path of each Persistent Volume to match local folders on <imaging-host>
# Then apply the configuration:

kubectl apply -f ClusterStorage-local.yaml

# Check Persistent Volumes status:

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
