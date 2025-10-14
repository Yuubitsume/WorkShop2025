resource "aws_vpc" "pra_vpc" {
  cidr_block = "10.1.0.0/16"
  tags = { Name = "PRA-Site-B-VPC" }
}

resource "aws_instance" "k8s_node" {
  count         = 3 # 3 nodes minimum pour la haute disponibilité du cluster
  ami           = "ami-xxxxxxxxxxxx" # ID d'une image Linux stable
  instance_type = "t3.large"

  subnet_id = aws_subnet.pra_subnet[0].id
  key_name  = "ansible-ssh-key" # Clé pour l'accès Ansible

  tags = {
    Name = "k8s-worker-node-${count.index}"
  }
}

output "worker_ips" {
  description = "Liste des IPs privées des nœuds worker"
  value       = aws_instance.k8s_node[*].private_ip
}