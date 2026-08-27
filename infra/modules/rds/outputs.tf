output "rds_endpoint" {
  value = aws_db_instance.main.address
}

output "rds_security_group_id" {
  value = aws_security_group.rds.id
}

output "rds_database_name" {
  value = aws_db_instance.main.db_name
}

