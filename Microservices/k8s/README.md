# Kubernetes Manifests for E-Commerce Microservices

This folder contains Kubernetes manifests to deploy the E-Commerce microservices application on a Kubernetes cluster (e.g., Minikube).

## Microservices

- **User Service** (`port: 3000`)
- **Product Service** (`port: 3001`)
- **Order Service** (`port: 3002`)
- **Gateway Service** (`port: 3003`)

Each service has its own `deployment.yaml` and `service.yaml` in their respective subfolders.

## Folder Structure

```
k8s/
  gateway-service/
    deployment.yaml
    service.yaml
  order-service/
    deployment.yaml
    service.yaml
  product-service/
    deployment.yaml
    service.yaml
  user-service/
    deployment.yaml
    service.yaml
  ingress/
    ingress.yaml
```

## How to Deploy

1. **Create a Namespace (optional):**
   ```sh
   kubectl create namespace ecom-app
   ```

2. **Apply Deployments and Services:**
   ```sh
   kubectl apply -f user-service/ -n ecom-app
   kubectl apply -f product-service/ -n ecom-app
   kubectl apply -f order-service/ -n ecom-app
   kubectl apply -f gateway-service/ -n ecom-app
   ```

3. **Apply Ingress (if using Ingress Controller):**
   ```sh
   kubectl apply -f ingress/ingress.yaml -n ecom-app
   ```

4. **Port Forwarding (for local testing):**
   ```sh
   kubectl port-forward svc/user-service 3000:3000 -n ecom-app
   kubectl port-forward svc/product-service 3001:3001 -n ecom-app
   kubectl port-forward svc/order-service 3002:3002 -n ecom-app
   kubectl port-forward svc/gateway-service 3003:3003 -n ecom-app
   ```

## Notes

- Make sure your Docker images are available to your Kubernetes cluster (push to Docker Hub or use Minikube's Docker daemon).
- The [ingress/ingress.yaml](ingress/ingress.yaml) file sets up routing for all services under the `ecommerce.local` host.

---