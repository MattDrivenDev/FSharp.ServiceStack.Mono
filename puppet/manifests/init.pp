group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
  content => "Welcome to your server\n"
}

file { "/var/www":
    ensure => "directory",        
}

exec { "apt-get update":
    command => "/usr/bin/apt-get update",
}

package { "mono-runtime":
	ensure => present,
	require => Exec["apt-get update"],
}

package { "mono-fastcgi-server4":
	ensure => present,
	require => Package["mono-runtime"],
}

package { "nginx":
    ensure => present,
    require => Package["mono-fastcgi-server4"],
}

service { "nginx":
    ensure => running,
    require => Package["nginx"],
    restart => "/usr/bin/sudo /etc/init.d/nginx restart",
}

class { 'mysql':
	root_password => 'hellopassword',
	require       => Exec['apt-get update'],
}

mysql::grant { 'servicestack':
	mysql_privileges     => 'ALL',
	mysql_db             => 'servicestack',
	mysql_user           => 'servicestack',
	mysql_password       => 'servicestackpw',
	mysql_host           => 'localhost',
	mysql_grant_filepath => '/home/vagrant/puppet-mysql',
}

file { "vagrant-nginx":
    path => "/etc/nginx/sites-available/default",
    ensure => file,
    replace => true,
    require => Package["nginx"],
    source => "puppet:///modules/nginx/vagrant",
    notify => Service["nginx"],    
}

exec { "start-fastcgi-mono-server4":
	logoutput => "on_failure",
    group => 'www-data',
    user => 'www-data',
	command => "/usr/bin/fastcgi-mono-server4 /applications=/:/var/www /filename=/tmp/SOCK-ServiceStack /socket=unix &",
	require => File["vagrant-nginx"],
}

include mysql