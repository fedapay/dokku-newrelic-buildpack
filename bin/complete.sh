#!/usr/bin/env bash

echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' | tee /etc/apt/sources.list.d/newrelic.list

wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add -

apt-get update

apt-get -y install newrelic-php5

sudo NR_INSTALL_SILENT=1 newrelic-install install

sed -i -e "s/REPLACE_WITH_REAL_KEY/1ed0961d4926151e56a9e9ef52a86d254c8dNRAL/" \
  -e "s/newrelic.appname[[:space:]]=[[:space:]].*/newrelic.appname=\"fedapay-checkout-sandbox\"/" \
  -e '$anewrelic.distributed_tracing_enabled=true' \
  $(php -r "echo(PHP_CONFIG_FILE_SCAN_DIR);")/newrelic.ini
