output "mb_db_user" {
  value = var.db_username
}
output "mb_db_pass" {
  value = data.aws_secretsmanager_secret_version.db_password.secret_string
  sensitive = true
}
output "mb_db_host" {
  value = aws_db_instance.postgres.address
}