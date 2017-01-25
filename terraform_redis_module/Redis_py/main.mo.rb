morb do

  resource :google_compute_http_health_check, :default1 do
    name                "tff-redis-basic-check"
    request_path        "/"
    check_interval_sec  1
    healthy_threshold   1
    unhealthy_threshold 10
    timeout_sec         1
  end
  
  resource :google_compute_target_pool, :default1 do
		name          'tff-redis-target-pool'
		instances     [
					  '${google_compute_instance.redis_server1.*.self_link}',
					  '${google_compute_instance.client1.*.self_link}',
					  ]
		health_checks ['${google_compute_http_health_check.default1.name}']
  end
  
	resource :google_compute_forwarding_rule, :default1 do
    name       'tff-redis-forwarding-rule'
    target     '${google_compute_target_pool.default1.self_link}'
    port_range '80'
  end

	resource :google_compute_instance, 'redis_server1' do
		name         'tff-redis-server'
		machine_type 'f1-micro'
		zone         'asia-east1-a'
		tags         ['www-node']
	
		disk do
			image 'ubuntu-os-cloud/ubuntu-1404-trusty-v20170110'
		end
  
		network_interface do
			network 'default'
			access_config do
				#Ephemeral
			end
		end
  
		provisioner 'file' do
			connection do
				type        'ssh'
				user        'root'
				private_key '${file("${var.private_key_path}")}'
				agent       false
			end
			source      '${var.install_script_src_path}'
			destination '${var.install_script_dest_path}'
		end

		provisioner 'remote-exec' do
			connection do
				type        'ssh'
				user        'root'
				private_key '${file("${var.private_key_path}")}'
				agent       false
			end
			inline [
					'chmod +x ${var.install_script_dest_path}',
					'${var.install_script_dest_path} ${var.redis_server_port}',
					' redis-server /etc/redis/${var.redis_server_port}.conf',
						]
		end
  
		metadata do
			ssh_keys :dash, "root:#{IO.read('/home/ashwin/.ssh/modables-demo-bucket.pub')}"
		end
  
		service_account do
			scopes ['https://www.googleapis.com/auth/compute.readonly']
		end
		
	end

	resource :google_compute_instance, :client1 do
		name         'tff-client'
		machine_type 'f1-micro'
		zone         'asia-east1-a'
		tags         ['www-node']
	
		disk do
			image 'ubuntu-os-cloud/ubuntu-1404-trusty-v20170110'
		end
  
		network_interface do
			network 'default'
			access_config do
				#Ephemeral
			end
		end
  
		provisioner 'file' do
			connection do
				type        'ssh'
				user        'root'
				private_key '${file("${var.private_key_path}")}'
				agent       false
			end
			source      '${var.client_script_src_path}'
			destination '${var.client_script_dest_path}'
		end

		provisioner 'remote-exec' do
			connection do
				type        'ssh'
				user        'root'
				private_key '${file("${var.private_key_path}")}'
				agent       false
			end
     inline ['sudo apt-get -y update',
             'sudo apt-get -y install python-redis',
             'touch ${var.client_script_dest_path}/log.txt',
             'python2 ${var.client_script_dest_path} ${google_compute_instance.redis_server1.network_interface.0.address} ${var.redis_server_port}',
            ]
		end
  
		metadata do
			ssh_keys :dash, "root:#{IO.read('/home/ashwin/.ssh/modables-demo-bucket.pub')}"
		end
  
		service_account do
			scopes ['https://www.googleapis.com/auth/compute.readonly']
		end
		
	end
	
	resource :google_compute_firewall, :default1 do
		name    'tff-redis-firewall'
		network 'default'


		allow do
			protocol 'tcp'
			ports    ['80']
		end

		source_ranges ['0.0.0.0/0']
		target_tags   ['www-node']

	end

end
