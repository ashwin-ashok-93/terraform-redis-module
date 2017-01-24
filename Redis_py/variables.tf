variable "install_script_src_path" {
  description = "Path to install script within this repository"
  default     = "/data/TF_LAMP_GCE_moduletest/terraform_redis_module/Scripts/InstallRedis.sh"
}

variable "install_script_dest_path" {
  description = "Path to put the install script on each destination resource"
  default     = "/tmp/InstallRedis.sh"
}

variable "client_script_src_path" {
  description = "Path to install script within this repository"
  default     = "/data/TF_LAMP_GCE_moduletest/terraform_redis_module/Scripts/redis-client.py"
}

variable "client_script_dest_path" {
  description = "Path to put the install script on each destination resource"
  default     = "~/redis-client.py"
}

variable "redis_server_port" {
  description = "Path to put the install script on each destination resource"
  default     = 7000
}

variable "private_key_path" {
  description = "Path to file containing private key"
  default     = "/home/ashwin/.ssh/modables-demo-bucket"
}
