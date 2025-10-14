output "worker_public_ips" {
  description = "Liste des IPs publiques des nœuds Worker (pour Ansible et test)"
  value       = aws_instance.k8s_node[*].public_ip
}

output "control_plane_ip" {
  description = "IP publique du nœud Control Plane (si séparé)"
  value       = aws_instance.k8s_control_plane.public_ip
}