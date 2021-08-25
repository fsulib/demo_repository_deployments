# Set up timezone
rm -f /etc/localtime
ln -s /usr/share/zoneinfo/US/Eastern /etc/localtime

# Update repository info and install base utils 
apt update
apt -y upgrade
apt -y install \
    zip \
    unzip

# Install Docker
apt -y install
    curl \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt update
apt -y install docker-ce
