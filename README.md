# QualiExplore Stack

## Summary

This stack deploys:

* One MongoDB containing the QualiExplore users
* One Neo4J database containing the QualiExplore knowledge graph
* One Apollo GraphQL server to communicate with MongoDB
* One Apollo GraphQl server to communicate with Neo4J
* One QualiExplore service
* One temporary container that contains seed users for the MongoDB

Use the following docker command to run this project:

 ``` shell
 docker compose up -d
 ```

## Web-based MongoDB admin interface

* To have a web-based interface of mongodb on local server please run the following docker commands:

* Pull mongo-express image from dockerhub  

``` shell
docker pull mongo-express
```

* Connect mongo-express to mongodb with qualiexlpore_net:

``` shell
docker run -d -p 8082:8081 -e ME_CONFIG_MONGODB_ADMINUSERNAME=root -e ME_CONFIG_MONGODB_ADMINPASSWORD=example --net qualiexplore_net --name mongo-express -e ME_CONFIG_MONGODB_SERVER=mongodb mongo-express
```

## Setup

### Neo4j

Login to Neo4j with the default user (user is "neo4j" and password is "neo4j") and change the initial password.
Set this password in the environment variable in the Apollo server for Neo4J.

### MongoDB

Create a database named "qualiexplore" and a collection named "users".

MongoDB does not have a default user. There is no user or password required in this stack.
Add a user to increase the stack's security.

## Development hints

When you deploy this stack on a local machine, make sure that the HOST variable for the "gql-mongo" service is "graphqlBackend". Otherwise, local testing will cause a CORS error.

### Knowledge graph

A graph organizes the knowledge for QualiExplore. Each tree element represents a single entity defined by its properties (e.g., name and description) and relations.
This is necessary because each element exists within the context of its branch and might receive its own name or description.

In future versions, similar elements could be associated through tags (which means a new type of node).
