

provider "google" {
  region      = "asia-east1"
  project     = "calcium-verbena-154713"
  credentials = "${file("/data/TF_LAMP_GCE_moduletest/terraform_redis_module/Main/credentials.json")}"
}


module "Redis_py"{
	source = "/data/TF_LAMP_GCE_moduletest/terraform_redis_module/Redis_py"
	redis_server_port = 7026
	}
