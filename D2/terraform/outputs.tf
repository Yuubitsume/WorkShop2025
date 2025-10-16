output "public_ip" {
  description = "The public IP address of the web server"
  value       = aws_instance.web.public_ip
}

output "instance_id" {
  description = "The ID of the web server instance"
  value       = aws_instance.web.id
}

