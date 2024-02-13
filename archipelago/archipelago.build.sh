rm -f /etc/localtime
ln -s /usr/share/zoneinfo/US/Eastern /etc/localtime

apt update
apt -y upgrade
apt -y install zip unzip apt-transport-https

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt -y install docker-ce docker-compose

cd /; git clone --branch 1.3.0 https://github.com/esmero/archipelago-deployment
cd /archipelago-deployment; git checkout 1.3.0
cp /demo_repository_deployments/archipelago/archipelago.docker-compose.yml /archipelago-deployment/docker-compose.yml
docker-compose pull
docker-compose up -d
chown -R 8183:8183 persistent/iiifcache
chown -R 8983:8983 persistent/solrcore
docker exec esmero-php bash -c "chown -R www-data:www-data private"
docker exec esmero-minio bash -c "cd /root; curl https://dl.min.io/client/mc/release/linux-amd64/mc --output mc; chmod +x mc; mv mc /usr/local/bin/"
docker exec esmero-minio bash -c "cd /data; mc mb archipelago; mc anonymous set public archipelago"
docker exec esmero-php bash -c "composer install"
docker exec esmero-php bash -c 'scripts/archipelago/setup.sh'
docker exec -u www-data esmero-php bash -c "cd web;../vendor/bin/drush -y si --verbose --existing-config --db-url=mysql://root:esmerodb@esmero-db/drupal --account-name=admin --account-pass=archipelago -r=/var/www/html/web --sites-subdir=default --notify=false;drush cr;chown -R www-data:www-data sites;"
docker exec esmero-php bash -c 'drush urol administrator "admin"'
docker exec esmero-php bash -c 'drush user:password admin admin'
docker exec esmero-php bash -c 'drush ucrt jsonapi --password="jsonapi"; drush urol metadata_api "jsonapi"'
docker exec esmero-php bash -c 'drush ucrt demo --password="demo"; drush urol metadata_pro "demo"'
docker exec esmero-php bash -c 'scripts/archipelago/deploy.sh'
