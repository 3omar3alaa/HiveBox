# Kubernetes
This readme goes through the required steps to create a **KIND** Kubernetes cluster and deploy this project on it

## Kind & Prerequisites Installation

### Install KIND

Install Kind using the following commands

``` 
# For AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.26.0/kind-linux-amd64
# For ARM64
[ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.26.0/kind-linux-arm64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```

For more details please refer to this [link](https://kind.sigs.k8s.io/docs/user/quick-start)

### Install Kubectl

Install Kubectl using the following command
```
snap install kubectl --classic
```
For other kubectl installation options please refer to this [link](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)

### Install GO

Install GO using the following command
```
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.23.4.linux-amd64.tar.gz

export PATH=$PATH:/usr/local/go/bin

# To persist the previous command, apply the following command instead
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
```
For more details please refer to this  [link](https://go.dev/doc/install)

## Cluster Creation

Use the following command

```
kind create cluster
```
If you have more than one cluster installed, then update the cluster context

```
kubectl cluster-info --context kind-kind
```

## Load Balancer
Install and run [Cloud Provider Kind](https://github.com/kubernetes-sigs/cloud-provider-kind) to facilitate the communication with the services inside the KIND cluster

Run the following command 

```
go install sigs.k8s.io/cloud-provider-kind@latest
```

Now open a new terminal and run Cloud Provider Kind and keep it running using the following command

```
~/go/bin/cloud-provider-kind 
```

If Cloud Provider Kind responded with the following error

> - probe HTTP address https://kind-control-plane:6443
> - Failed to connect to HTTP address https://kind-control-plane:6443: Get "https://kind-control-plane:6443": context deadline exceeded (Client.Timeout exceeded while awaiting headers)

This means that Cloud Provider Kind can't reach the control-plane-node of the cluster. To solve this issue, get the IP of the control-plane-node and add it to /etc/hosts file by following these commands

```
docker container inspect kind-control-plane --format '{{ .NetworkSettings.Networks.kind.IPAddress }}'
sudo echo "<control-plane-ip> kind-control-plane" >> /etc/hosts
```

For more information about Cloud Provider kind follow this [link](https://kind.sigs.k8s.io/docs/user/loadbalancer/) and [Github Page](https://github.com/kubernetes-sigs/cloud-provider-kind)

## Ingress NGINX

Install Nginx Ingress

```
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/deploy-ingress-nginx.yaml
```
Now the Ingress is all setup. Wait until is ready to process requests running

```
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s
```
For more information refer to this [link](https://kind.sigs.k8s.io/docs/user/ingress/)

## Deployment

Apply the following commands to deploy the hivebox project and prometheus into the cluster

```
kubectl apply -f config-maps/prometheus-config.yaml
kubectl apply -f deployments/prometheus.yaml
kubectl apply -f deployments/hivebox.yaml
kubectl apply -f services/prometheus.yaml
kubectl apply -f services/hivebox.yaml
kubectl apply -f ingress/hivebox-ingress.yaml
kubectl apply -f ingress/prometheus-ingress.yaml
```

## Accessing The Services

Now to access the services use the following steps
- Get the **External IP** of the nginx-ingress-controller
```
LOADBALANCER_IP=$(kubectl get services \
   --namespace ingress-nginx \
   ingress-nginx-controller \
   --output jsonpath='{.status.loadBalancer.ingress[0].ip}')
```
- Access hivebox service APIs
```
curl ${LOADBALANCER_IP}/docs
```

- Access Prometheus page
```
curl ${LOADBALANCER_IP}/prometheus/query
```

## Cluster Deletion

Use the following command
```
kind delete cluster
```
