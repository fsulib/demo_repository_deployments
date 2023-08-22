cd /
git clone https://github.com/IQSS/dataverse-docker
cd /dataverse-docker
bash ./demostart.sh

echo "Waiting for Dataverse to wake up..."
sleep 300
docker exec dataverse bash -c 'curl -X POST "http://localhost:8080/api/admin/superuser/dataverseAdmin"'
