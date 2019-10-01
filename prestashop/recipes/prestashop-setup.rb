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
    chmod -R 777 /var/www/html/prestashop/var/
    rm prestashop*.zip
    EOH
  cwd '/tmp'
  # notifies :run, 'bash[install-prestashop]', :immediately
  user 'root'
end

# Bash script to install PrestaShop
# (it doesn't install PrestaShop properly, so we don't really execute it):
bash 'install-prestashop' do
  action :nothing
  code <<-EOH
    chmod -R 777 /var/www/html/prestashop/
    php /var/www/html/prestashop/install/index_cli.php --language=#{node['prestashop']['ps_language']} --name=#{node['prestashop']['ps_name']} --country=#{node['prestashop']['ps_country']} --firstname=#{node['prestashop']['ps_firstname']} --lastname=#{node['prestashop']['ps_lastname']} --email=#{node['prestashop']['ps_email']} --password=#{node['prestashop']['ps_password']} --db_server=#{node['prestashop']['psdb_server']} --db_name=#{node['prestashop']['psdb_name']} --db_user=#{node['prestashop']['psdb_user']} --db_password=#{node['prestashop']['psdb_password']} --db_clear=1 --db_create=0 --prefix=#{node['prestashop']['psdb_prefix']}
    chmod -R 664 /var/www/html/prestashop/
    find /var/www/html/prestashop/ -type d -print0 | xargs -0 chmod 775
    rm -R /var/www/html/prestashop/install/
    EOH
  user 'root'
end

# Command to install PrestaShop:
# php /var/www/html/prestashop/install/index_cli.php --language='en' --name='PrestaShop' --country='en' --firstname='Jhon' --lastname='Doe' --email='jhondoe@prestashop.com' --password='0123456789' --db_server='127.0.0.1' --db_name='prestashop' --db_user='ps_user' --db_password='ps_user' --db_clear=1 --db_create=0 --prefix='ps_'
