#
# Cookbook:: prestashop
# Recipe:: php-setup
#
# Copyright:: 2019, J. Francisco Martín, All Rights Reserved.

# Install the required PHP packages:
package %w(php libapache2-mod-php php-curl php-gd php-intl php-mysql php-zip php7.2-xml) do
  action :install
  notifies :reload, 'service[apache2]', :immediately
end

# Create a file which prints information about the current PHP configuration:
template '/var/www/html/info.php' do
  action :create
  mode '0755'
  notifies :reload, 'service[apache2]', :immediately
  owner 'root'
  source 'info-php.erb'
end
