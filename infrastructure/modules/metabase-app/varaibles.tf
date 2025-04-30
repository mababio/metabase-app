variable "ingress_host" {
    description = "The host for the ingress"
    type        = string
    default     = "metabase.example.com"
}
variable "image_tag" {
    description = "The image tag for the Metabase app"
    type        = string
    default     = "latest"
}

variable "replica_count" {
    description = "The number of replicas for the Metabase app"
    type        = number
    default     = 1
}

variable "mb_db_user" {
    description = "The database user for Metabase"
    type        = string
    default     = "metabaseuser"
}
variable "mb_db_pass" {
    description = "The database password for Metabase"
    type        = string
}
variable "mb_db_host" {
    description = "The database host for Metabase"
    type        = string
    default     = "metabase-db.example.com"
}