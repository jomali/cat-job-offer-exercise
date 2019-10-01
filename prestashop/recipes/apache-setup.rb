#
# Cookbook:: prestashop
# Recipe:: apache-setup
#
# Copyright:: 2019, J. Francisco Martín, All Rights Reserved.

# apache2_install 'default_install'
#
# apache2_module "php7" do
#   name "libphp7.so"
# end
#
# # service['apache2'] is defined in the apache2_default_install resource but
# # other resources are currently unable to reference it. To work around this
# # issue, the following helper is defined:
# service 'apache2' do
#   extend Apache2::Cookbook::Helpers
#   service_name lazy { apache_platform_service_name }
#   supports restart: true, status: true, reload: true
#   action :nothing
# end

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
