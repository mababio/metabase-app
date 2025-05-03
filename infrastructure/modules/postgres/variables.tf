variable "db_identifier" {
    description = "The identifier for the DB instance"
    type        = string
    default     = "metabase-postgres"
}
variable "db_name" {
    description = "The name of the database to create"
    type        = string
    default     = "metabase"
}
variable "db_username" {
    description = "The username for the database"
    type        = string
    default     = "metabaseuser"
}
variable "vpc_id" {
    description = "The VPC ID where the DB instance will be created"
    type        = string
}
variable "subnet_ids" {
  description = "The list of subnet IDs for the DB instance"
  type = list(string)
}
variable "allowed_cidrs" {
  type    = list(string)
  default = ["10.0.0.0/16"]  # Adjust as needed
}

variable "aws_secret_id_postgres" {
    description = "The AWS Secrets Manager secret ID for the database password"
    type        = string
    default     = "metabase-db-password"
}
