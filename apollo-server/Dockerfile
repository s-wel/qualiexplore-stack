FROM node:18

WORKDIR /app

RUN npm install @neo4j/graphql graphql neo4j-driver apollo-server 
RUN npm install dotenv --save

COPY ./apollo-server/app /app

CMD node index.js