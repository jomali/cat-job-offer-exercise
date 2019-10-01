#
# Cookbook:: prestashop
# Recipe:: prestashop-setup
#
# Copyright:: 2019, J. Francisco Martín, All Rights Reserved.

# Bash script to download PrestaShop:
bash 'download-prestashop' do
  action :run
  code <<-EOH
    wget https://github.com/PrestaShop/PrestaShop/releases/download/#{node['prestashop']['ps_version']}/prestashop_#{node['prestashop']['ps_version']}.zip
    EOH
  cwd '/tmp'
  user 'root'
end
