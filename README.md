# presto-server
Presto Server Deployment with pinot 

# How to deploy!

Hi! Here we will deploy the presto server for **pinot db**. 

### prerequisite
* git
* docker

# STEPS

Follow these steps to configure and deploy,  the **pinot server** 

## 1) Clone the source project
> git clone https://github.com/pckushan/presto-server.git
> 
## 2) Edit the *Dockerfile*
Get  a version of the presto binary from [presto-server version list]([https://repo1.maven.org/maven2/com/facebook/presto/presto-server/](https://repo1.maven.org/maven2/com/facebook/presto/presto-server/))
add the selected version number from the list given above to the **Dockerfile**
	
	ARG PRESTO_VERSION=0.230
	
## 3) Edit the configurations

***etc*** file contains the configurations,
#### catalog/ 
	Inside the etc/catalog folder, create a property file and add the configuration lines
	ex: nano pinot.properties
	------------------------------------
	connector.name=pinot
	pinot.controller-urls=localhost:9000
	------------------------------------
#### config.properties
	Create a config property file and add the configuration lines
	ex: nano config.properties
	------------------------------------
	coordinator=true
	node-scheduler.include-coordinator=true
	http-server.http.port=8085	
	query.max-memory=5GB
	query.max-memory-per-node=1GB
	query.max-total-memory-per-node=2GB
	discovery-server.enabled=true
	discovery.uri=http://example.net:8085
	------------------------------------
#### node.properties
	Create a node property file and add the configuration lines
	ex: nano node.properties
	------------------------------------
	node.environment=production
	node.id=d5495e88-432a-11ea-b77f-2e728ce88125
	node.data-dir=/var/presto/data
	------------------------------------
#### log.properties
	Create a log property file and add the configuration lines
	ex: nano log.properties
	------------------------------------
	com.facebook.presto=INFO
	------------------------------------
#### jvm.config
	Create a jvm property file and add the configuration lines
	ex: nano jvm.properties
	------------------------------------
	-server
	-Xmx16G
	-XX:+UseG1GC
	-XX:G1HeapRegionSize=32M
	-XX:+UseGCOverheadLimit
	-XX:+ExplicitGCInvokesConcurrent
	-XX:+HeapDumpOnOutOfMemoryError
	-XX:+ExitOnOutOfMemoryError
	------------------------------------
	
## 4) Build the image
Build the image by the Dockerfile,

	docker image build -t prestopinot:0.1 .
## 5) Run  the container with the created image
Run the image created,

	docker run -p 8085:8085 -d prestopinot:0.1


Ok... now you can enjoy :) 
