#
# Cookbook:: prestashop
# Recipe:: mariadb-setup
#
# Copyright:: 2019, J. Francisco Martín, All Rights Reserved.

# Install the required MariaDB packages:
package %w(mariadb-server mariadb-client) do
  action :install
end

template '/tmp/mysql.sql' do
  action :create
  mode '0755'
  owner 'root'
  source 'mysql.conf.erb'
end

execute 'mysql-initialization' do
  command '/usr/bin/mysql -sfu root < /tmp/mysql.sql && ls /tmp/mysql.sql'
  ignore_failure true
  user 'root'
end
