variable "aws_region" {
  description = "Région AWS pour le Site de Secours (B)"
  type        = string
  default     = "eu-central-1" # Exemple
}

variable "instance_type" {
  description = "Type d'instance pour les nœuds Kubernetes"
  type        = string
  default     = "t3.large"
}

variable "k8s_node_count" {
  description = "Nombre de nœuds pour le cluster K8s"
  type        = number
  default     = 3
}

variable "ssh_key_name" {
  description = "Nom de la clé SSH utilisée par Ansible"
  type        = string
  default     = "ansible-ssh-key"
}