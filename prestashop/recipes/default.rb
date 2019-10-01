#
# Cookbook:: prestashop
# Recipe:: default
#
# Copyright:: 2019, J. Francisco Martín, All Rights Reserved.

# Manage APT repository updates on Debian and Ubuntu platforms:
apt_update 'daily apt-update' do
  frequency 86_400
  action :periodic
end

# Install Apache, PHP and MariaDB:
include_recipe 'prestashop::apache-setup'
include_recipe 'prestashop::php-setup'
include_recipe 'prestashop::mariadb-setup'

# Install PrestaShop:
include_recipe 'prestashop::prestashop-setup'
