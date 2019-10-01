#
# Cookbook:: prestashop
# Recipe:: mariadb-setup
#
# Copyright:: 2019, J. Francisco Martín, All Rights Reserved.

# Install the required MariaDB packages:
package %w(mariadb-server mariadb-client) do
  action :install
end
