terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "apache_server_mod_jk_worker_failures" {
  source    = "./modules/apache_server_mod_jk_worker_failures"

  providers = {
    shoreline = shoreline
  }
}