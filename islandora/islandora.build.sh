rm -f /etc/localtime
ln -s /usr/share/zoneinfo/US/Eastern /etc/localtime

apt update
apt -y upgrade
apt -y install zip unzip apt-transport-https make

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt -y install docker-ce

DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

cd /; git clone https://github.com/Islandora-Devops/isle-dc
cp /demo_repository_deployments/islandora/islandora.env /isle-dc/.env
cp /demo_repository_deployments/islandora/islandora.docker-compose.yml /isle-dc/docker-compose.yml
cp /demo_repository_deployments/islandora/islandora.Makefile /isle-dc/Makefile
#make starter_dev
