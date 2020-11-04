function global:UPDATE-DOCKER {

Write-Output ("Updating docker:")

Write-Output ("Updating DB:")
docker stop db
docker rm db
docker rmi registry.adacta-group.com/adinsure/basic/db
docker pull registry.adacta-group.com/adinsure/basic/db
docker run -d -p 1444:1433 --name db registry.adacta-group.com/adinsure/basic/db

Write-Output ("Updating WEB:")

docker stop web
docker rm web
docker rmi registry.adacta-group.com/adinsure/basic
docker pull registry.adacta-group.com/adinsure/basic
docker run -d -p 81:80 --memory 3g -v D:\Docker\Logs:C:\Logs --name web registry.adacta-group.com/adinsure/basic

Write-Output ("Updating ES:")

docker stop es
docker rm es
docker rmi registry.adacta-group.com/adinsure/core/es
docker pull registry.adacta-group.com/adinsure/core/es
docker run -d -p 9200:9200 --name es -v es_data:C:\es_data registry.adacta-group.com/adinsure/core/es

Write-Output ("Updating AMQ:")

docker stop amq
docker rm amq
docker rmi registry.adacta-group.com/adinsure/core/amq
docker pull registry.adacta-group.com/adinsure/core/amq
docker run -d -p 61616:61616 -p 8161:8161 --name amq -v amq_data:C:\activemq\data registry.adacta-group.com/adinsure/core/amq
	
}

function global:RUN-DOCKER {

docker run -d -p 1444:1433 --name db registry.adacta-group.com/adinsure/basic/db
docker run -d -p 81:80 --memory 3g -v D:\Docker\Logs:C:\Logs --name web registry.adacta-group.com/adinsure/basic
docker run -d -p 9200:9200 --name es -v es_data:C:\es_data registry.adacta-group.com/adinsure/core/es
docker run -d -p 61616:61616 -p 8161:8161 --name amq -v amq_data:C:\activemq\data registry.adacta-group.com/adinsure/core/amq

}