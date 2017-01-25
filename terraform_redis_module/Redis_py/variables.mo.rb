morb do

  variable :install_script_src_path do 
    description 'Path to install script within this repository'
    default     '/data/TF_LAMP_GCE_moduletest/terraform_redis_module/Scripts/InstallRedis.sh'
  end
  
  variable :install_script_dest_path do 
    description 'Path to put the install script on each destination resource'
    default     '/tmp/InstallRedis.sh'
  end
  
  variable :client_script_src_path do
    description 'Path to install script within this repository'
    default     '/data/TF_LAMP_GCE_moduletest/terraform_redis_module/Scripts/redis_client.py'
  end

  variable :client_script_dest_path do
    description 'Path to put the install script on each destination resource'
    default     '~/redis_client.py'
  end
  
  variable :redis_server_port do
    description 'Path to put the install script on each destination resource'
    default     7000
  end
  
  variable :private_key_path do
    description 'Path to file containing private key'
    default     '/home/ashwin/.ssh/modables-demo-bucket'
  end
  
end

