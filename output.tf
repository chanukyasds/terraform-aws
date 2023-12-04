
# output "available_zones_names" {
#   value = data.aws_availability_zones.available_zones.names
# }

# output "available_zones_count" {
#   value = length(data.aws_availability_zones.available_zones.names)
# }

output "aws_rds_endpoint" {
  value = aws_db_instance.postgres_rds.endpoint
}

output "ec2_hostname" {
  value = aws_instance.ubuntu_machine.public_dns
}