rm -f /etc/localtime
ln -s /usr/share/zoneinfo/US/Eastern /etc/localtime

apt update
apt -y upgrade
apt -y install zip unzip apt-transport-https

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt -y install docker-ce docker-compose

cd /; git clone https://github.com/fsulib/demo_repository_deployments
cd /; git clone https://github.com/DSpace/dspace-angular
cd /dspace-angular; git checkout dspace-7_x
cp /demo_repository_deployments/dspace/custom.cli.yml /dspace-angular/docker/cli.yml
docker-compose -f docker/docker-compose.yml -f docker/docker-compose-rest.yml pull
docker-compose -p d7 -f docker/docker-compose.yml -f docker/docker-compose-rest.yml -f docker/db.entities.yml up -d
docker network create docker_dspacenet
docker-compose -p d7 -f docker/cli.yml -f docker/cli.assetstore.yml run --rm dspace-cli
