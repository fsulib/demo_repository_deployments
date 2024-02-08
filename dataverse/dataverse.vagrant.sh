# Set up timezone
rm -f /etc/localtime
ln -s /usr/share/zoneinfo/US/Eastern /etc/localtime

# Update repository info and install base utils 
apt update
apt -y upgrade
apt -y install zip unzip apt-transport-https

# Install Docker & Docker Compose
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt -y install docker-ce docker-compose

# Run Dataverse demo build
cd /
git clone https://github.com/fsulib/demo_repository_deployments
/demo_repository_deployments/dataverse/dataverse.build.sh
