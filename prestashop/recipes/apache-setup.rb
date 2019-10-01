#
# Cookbook:: prestashop
# Recipe:: apache-setup
#
# Copyright:: 2019, J. Francisco Martín, All Rights Reserved.

# Install the Apache server:
package 'apache2'

# Enable 'mod_rewrite', a module that provides URL manipulation capability:
execute 'enable-mod_rewrite' do
  action :run
  command 'a2enmod rewrite'
  notifies :reload, 'service[apache2]', :immediately
  user 'root'
end

# Create the apache2 service:
service 'apache2' do
  supports restart: true, status: true, reload: true
  action [:enable, :start]
end
