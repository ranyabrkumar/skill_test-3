variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  description = "Existing key pair name for SSH into EC2"
  type        = string
}

# DockerHub creds - treat as sensitive
variable "dockerhub_user" {
  type      = string
  sensitive = true
}
variable "dockerhub_pass" {
  type      = string
  sensitive = true
}

# prefix (username) on DockerHub e.g. yourusername
variable "dockerhub_repo_prefix" {
  type    = string
  default = "yourdockerhubusername"
}

# Your IP for SSH (CIDR)
variable "my_ip_cidr" {
  description = "CIDR for SSH access (e.g. 1.2.3.4/32). Default 0.0.0.0/0 if you want open SSH (not recommended)."
  type    = string
  default = "0.0.0.0/0"
}
