#
# Cookbook:: prestashop
# Recipe:: prestashop-setup
#
# Copyright:: 2019, J. Francisco Martín, All Rights Reserved.

package 'unzip'

# Bash script to download and extract PrestaShop:
bash 'download-prestashop' do
  action :run
  code <<-EOH
    wget https://github.com/PrestaShop/PrestaShop/releases/download/#{node['prestashop']['ps_version']}/prestashop_#{node['prestashop']['ps_version']}.zip
    mkdir -p /var/www/html/prestashop
    unzip prestashop_*.zip
    unzip prestashop.zip -d /var/www/html/prestashop
    chmod -R 777 /var/www/html/prestashop/
    rm index.php
    rm prestashop*.zip
    EOH
  cwd '/tmp'
  user 'root'
end
