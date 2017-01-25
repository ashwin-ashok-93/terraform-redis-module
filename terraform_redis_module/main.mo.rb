morb do

  provider :google do
	region  'asia-east'
	project 'calcium-verbena-154713'
	credentials IO.read('credentials.json')
  end

  resource :google_compute_http_health_check, :default1 do
    name                "tff-redis-basic-check"
    request_path        "/"
    check_interval_sec  1
    healthy_threshold   1
    unhealthy_threshold 10
    timeout_sec         1
  end

#self.module :redis_python do
#	source            './Redis_py'
#	redis_server_port 7026
#	end

end
