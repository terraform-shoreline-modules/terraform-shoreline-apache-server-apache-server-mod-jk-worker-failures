resource "shoreline_notebook" "apache_server_mod_jk_worker_failures" {
  name       = "apache_server_mod_jk_worker_failures"
  data       = file("${path.module}/data/apache_server_mod_jk_worker_failures.json")
  depends_on = [shoreline_action.invoke_restart_apache]
}

resource "shoreline_file" "restart_apache" {
  name             = "restart_apache"
  input_file       = "${path.module}/data/restart_apache.sh"
  md5              = filemd5("${path.module}/data/restart_apache.sh")
  description      = "Restart the Apache server to see if that resolves the issue."
  destination_path = "/agent/scripts/restart_apache.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_restart_apache" {
  name        = "invoke_restart_apache"
  description = "Restart the Apache server to see if that resolves the issue."
  command     = "`chmod +x /agent/scripts/restart_apache.sh && /agent/scripts/restart_apache.sh`"
  params      = []
  file_deps   = ["restart_apache"]
  enabled     = true
  depends_on  = [shoreline_file.restart_apache]
}

