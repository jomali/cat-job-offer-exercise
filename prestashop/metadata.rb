name 'prestashop'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures prestashop'
long_description 'Installs/Configures prestashop'
version '0.1.0'
chef_version '>= 13.0'
depends 'apache2', '~> 7.1.1'
depends 'docker', '~> 4.9.3'
depends 'mariadb', '~> 2.1.0'
depends 'php', '~> 7.0.0'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/prestashop/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/prestashop'
