locals {
  filename           = var.rotation_type == "single" ? "SecretsManagerRDSMySQLRotationSingleUser.zip" : "SecretsManagerRDSMySQLRotationMultiUser.zip"
  lambda_description = var.rotation_type == "single" ? "Conducts an AWS SecretsManager secret rotation for RDS MySQL using single user rotation scheme" : "Conducts an AWS SecretsManager secret rotation for RDS MySQL using multi user rotation scheme"

  secret_string_single_bare = {
    username = var.mysql_username
    password = var.mysql_password
    engine   = "mysql"
    host     = var.mysql_host
    port     = var.mysql_port
    dbname   = var.mysql_dbname
  }
  secret_string_single_replica = {
    username    = var.mysql_username
    password    = var.mysql_password
    engine      = "mysql"
    host        = var.mysql_host
    port        = var.mysql_port
    dbname      = var.mysql_dbname
    replicahost = var.mysql_replicahost
  }
  secret_string_single = var.mysql_replicahost == null ? local.secret_string_single_bare : local.secret_string_single_replica

  secret_string_multi_bare = {
    username  = var.mysql_username
    password  = var.mysql_password
    engine    = "mysql"
    host      = var.mysql_host
    port      = var.mysql_port
    dbname    = var.mysql_dbname
    masterarn = var.secretsmanager_masterarn
  }
  secret_string_multi_replica = {
    username    = var.mysql_username
    password    = var.mysql_password
    engine      = "mysql"
    host        = var.mysql_host
    port        = var.mysql_port
    dbname      = var.mysql_dbname
    replicahost = var.mysql_replicahost
    masterarn   = var.secretsmanager_masterarn
  }
  secret_string_multi = var.mysql_replicahost == null ? local.secret_string_multi_bare : local.secret_string_multi_replica
}
