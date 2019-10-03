# prestashop

## Description

This cookbook prepares the PrestaShop software to be installed. There're two possibilities to do so:

1) If the attribute `node['prestashop']['use_docker']` is true, it launches two _docker_ containers; one with a MySQL database and another one with PrestaShop.

2) Otherwise, the cookbook installs an Apache web server, MariaDB, the required PHP modules and it downloads and extracts the PrestaShop software in the correct directory.

In any case you must install PrestaShop manually by going to `http://\<hostname\>/prestashop/install.php`

## Usage

Add the "prestashop" recipe to your node's run list or role, or include the recipe in another cookbook.

## Tests

Launch the command `kitchen verify` to launch the smoke tests for the cookbook.

## License and Author

Copyright 2019, J. Francisco Martín (jfm.lisaso@gmx.com)

All rights reserved, do not redistribute.
