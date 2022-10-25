server '54.249.239.103', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/home/goshawk/.ssh/id_rsa'