# Terraform AWS E-Commerce Deployment

This project provisions AWS infrastructure and deploys a Dockerized **E-Commerce application** using **Terraform**.  
The application has **five services**:
- **Frontend (port 3000)** – React app accessible from browser
- **User Service (port 3001)**
- **Products Service (port 3002)**
- **Orders Service (port 3003)**
- **Cart Service (port 3004)**

All backend services are containerized with Docker and run inside a single **EC2 instance**.  
The **frontend** proxies API requests to these backend services.

---

## 🚀 Features
- Terraform-managed AWS infrastructure
- Uses **default VPC** and one public subnet
- Security Group:
  - SSH (port 22) allowed from anywhere
  - HTTP (port 80) allowed from anywhere
  - Internal service ports (3001–3004) allowed 
- EC2 instance:
  - Amazon Linux 2
  - Installs Docker
  - Logs in to DockerHub
  - Pulls service images
  - Runs containers automatically on startup

---

## 📦 Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/downloads) v1.0+
- AWS CLI with credentials configured
- Docker images pushed to your DockerHub repo
- SSH key pair created in AWS

---

## ⚙️ Setup

### 1. Clone repo
```bash
git clone <your-repo-url>
cd <project-folder>
```

### 2. configure varaibales
```
aws_region           = "us-west-2"
instance_type        = "t2.micro"
key_name             = "<your-aws-keypair>"
my_ip_cidr           = "<your-ip>/32"
dockerhub_user       = "<dockerhub-username>"
dockerhub_pass       = "<dockerhub-password>"
dockerhub_repo_prefix = "<dockerhub-repo>"
```
### 3. Initialize Terraform
```
terraform init
```

### 4. Plan infrastructure
```
terrafrom plan
```
### 5. Apply infrastructure
```
terrafrom apply
```
### 6. To destroy all infrastructure:
```
terraform destroy
```

## Testing | Validation
## 1. Frontend service:
![frontend-service](https://github.com/user-attachments/assets/d8fefb7f-c856-472c-b041-dfcb85f14775)

## 2. User service
![user-service](https://github.com/user-attachments/assets/be3e9342-2776-4c68-82be-a15237a7a0a5)

## 3 . Product Service
![product-service](https://github.com/user-attachments/assets/830a6066-6d36-4420-853a-4bbc8349d85e)

## 4. Cart service
![Cart-service](https://github.com/user-attachments/assets/63d09da1-79c2-4dda-8a9e-339ee8dc26e0)

## 5. Order service
![order-service](https://github.com/user-attachments/assets/935ed289-4501-4e47-861a-5e92a49fabea)

## Terrafrom Apply result:
![terraform_apply](https://github.com/user-attachments/assets/8e287f76-d894-4120-906b-abea5903b481)

## Docker ps
![dockerps](https://github.com/user-attachments/assets/b1d84971-22f1-45a9-ad25-7c3ff62f13e0)











