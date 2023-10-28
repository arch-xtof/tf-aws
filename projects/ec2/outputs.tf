output "public_ips" {
  value = zipmap(aws_instance.ec2[*].tags["name"], aws_instance.ec2[*].public_ip)
}