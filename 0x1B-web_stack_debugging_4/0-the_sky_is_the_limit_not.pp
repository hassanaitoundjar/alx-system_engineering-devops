# This Puppet manifest is designed to optimize Nginx configuration for handling high load conditions

file { '/etc/nginx/nginx.conf':
  ensure  => file,
  content => template('nginx/nginx.conf.erb'),
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/nginx/nginx.conf'],
}

exec { 'fix--for-nginx':
  command     => '/usr/bin/nginx -s reload',
  refreshonly => true,
}
