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

if node['prestashop']['use_docker']
  docker_service 'default' do
    action [:create, :start]
  end

  # Create a network for containers to communicate:
  bash 'create-docker-network' do
    action :run
    code <<-EOH
      if [ ! "$(docker network ls | grep prestashop_net)" ]; then
        docker network create prestashop_net
      fi
      EOH
    user 'root'
  end

  # Launch mysql 5.7 container:
  bash 'create-mysql-container' do
    action :run
    code <<-EOH
      if [ ! "$(docker ps | grep mysql_container)" ]; then
        if [ "$(docker ps -aq -f name=mysql_container)" ]; then
          docker rm mysql_container
        fi
        docker run -ti --name mysql_container --network prestashop_net -e MYSQL_ROOT_PASSWORD=#{node['prestashop']['psdb_root_password']} -e MYSQL_DATABASE=#{node['prestashop']['psdb_name']} -e MYSQL_USER=#{node['prestashop']['psdb_user']} -e MYSQL_PASSWORD=#{node['prestashop']['psdb_password']} -p 3306:3306 -d mysql:5.7
      fi
      EOH
    user 'root'
  end

  # Launch prestashop 1.7 container:
  bash 'create-prestashop-container-a' do
    action :run
    code <<-EOH
      if [ ! "$(docker ps | grep prestashop_container_a)" ]; then
        if [ "$(docker ps -aq -f name=prestashop_container_a)" ]; then
          docker rm prestashop_container_a
        fi
        docker run -ti --name prestashop_container_a --network prestashop_net -e DB_SERVER=mysql_container -p 80:80 -d prestashop/prestashop:1.7
      fi
      EOH
    user 'root'
  end

  # Launch prestashop 1.7 container and install the software
  # (it doesn't work properly, so we don't really execute the script):
  bash 'create-prestashop-container-b' do
    action :nothing
    code <<-EOH
      if [ ! "$(docker ps | grep prestashop_container_b)" ]; then
        if [ "$(docker ps -aq -f name=prestashop_container_b)" ]; then
          docker rm prestashop_container_b
        fi
        docker run -ti --name prestashop_container_b --network prestashop_net \
          -e ADMIN_MAIL=#{node['prestashop']['ps_email']} \
          -e ADMIN_PASSWD=#{node['prestashop']['ps_password']} \
          -e PS_ALL_LANGUAGES=0 \
          -e PS_COUNTRY=#{node['prestashop']['ps_country']} \
          -e PS_DEMO_MODE=1 \
          -e PS_DEV_MODE=1 \
          -e PS_ENABLE_SSL=0 \
          -e PS_ERASE_DB=0 \
          -e PS_FOLDER_ADMIN=admin \
          -e PS_FOLDER_INSTALL=install \
          -e PS_HOST_MODE=0 \
          -e PS_INSTALL_AUTO=1 \
          -e PS_LANGUAGE=#{node['prestashop']['ps_language']} \
          -e DB_NAME=#{node['prestashop']['psdb_name']} \
          -e DB_PASSWD=#{node['prestashop']['psdb_password']} \
          -e DB_PREFIX=#{node['prestashop']['psdb_prefix']} \
          -e DB_SERVER=mysql_container \
          -e DB_USER=#{node['prestashop']['psdb_user']} -p 8080:80 -d prestashop/prestashop:1.7
      fi
      EOH
    user 'root'
  end
else
  # Install Apache, PHP and MariaDB:
  include_recipe 'prestashop::apache-setup'
  include_recipe 'prestashop::php-setup'
  include_recipe 'prestashop::mariadb-setup'
  # Install PrestaShop:
  include_recipe 'prestashop::prestashop-setup'
end
