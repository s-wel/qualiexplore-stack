# QualiExplore Stack

* This stack contains seeds for Mongodb. 
* It includes one more json (editableFilters.json) file.
* This file will be used further with the graphql server. For now, it is fetching from json-server
* Use the following docker command to run this project:
 `````
 docker-compose -f  docker-compose.yml up
 ```````

# Web-based MongoDB admin interface

* To have a web-based interface of mongodb on local server please run the following docker commands:

* Pull mongo-express image from dockerhub  
````
docker pull mongo-express
````
* Connect mongo-express to mongodb with qualiexlpore_net:
`````
docker run -d -p 8082:8081 -e ME_CONFIG_MONGODB_ADMINUSERNAME=root -e ME_CONFIG_MONGODB_ADMINPASSWORD=example --net qualiexplore_net --name mongo-express -e ME_CONFIG_MONGODB_SERVER=mongodb mongo-express
`````
To see the Interface please hit this server : http://localhost:8082/

![screenshot-localhost_8082-2022 06 09-22_19_28](https://user-images.githubusercontent.com/25609146/172936946-5339c2d8-7f94-4d35-990c-88f04c46babf.png)
