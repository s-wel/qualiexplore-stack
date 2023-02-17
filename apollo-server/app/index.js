// https://neo4j.com/docs/graphql-manual/current/getting-started/

// Define your GraphQL type definitions
const { Neo4jGraphQL } = require("@neo4j/graphql");
const { ApolloServer, gql } = require("apollo-server");
const neo4j = require("neo4j-driver");

const typeDefs = gql`
type FilterGroup {
	filterStatementsBelongsTo: [FilterStatement!]! @relationship(type: "BELONGS_TO", direction: IN)
	id: ID!
	name: String!
}

type FilterStatement {
	belongsToFilterGroups: [FilterGroup!]! @relationship(type: "BELONGS_TO", direction: OUT)
	id: ID!
	qualityFactorsRelevantFor: [QualityFactor!]! @relationship(type: "RELEVANT_FOR", direction: IN)
	text: String!
}

type LifeCyclePhase {
	id: ID!
	name: String!
	qualityCharacteristicsContributesTo: [QualityCharacteristic!]! @relationship(type: "CONTRIBUTES_TO", direction: IN)
}

type QualityCharacteristic {
	contributesToLifeCyclePhases: [LifeCyclePhase!]! @relationship(type: "CONTRIBUTES_TO", direction: OUT)
	description: String!
	id: ID!
	name: String!
	qualityFactorsContributesTo: [QualityFactor!]! @relationship(type: "CONTRIBUTES_TO", direction: IN)
	qualityFactorsRelevantFor: [QualityFactor!]! @relationship(type: "RELEVANT_FOR", direction: IN)
}

type QualityFactor {
	contributesToQualityCharacteristics: [QualityCharacteristic!]! @relationship(type: "CONTRIBUTES_TO", direction: OUT)
	description: String!
	id: ID!
	name: String!
	relevantForFilterStatements: [FilterStatement!]! @relationship(type: "RELEVANT_FOR", direction: OUT)
	relevantForQualityCharacteristics: [QualityCharacteristic!]! @relationship(type: "RELEVANT_FOR", direction: OUT)
	sources: String!
}
`;

require('dotenv').config();
const neo4j_user = process.env.NEO4J_USER;
const neo4j_password = process.env.NEO4J_PASSWORD;
const neo4j_url = process.env.NEO4J_URL;

console.log(`Connecting to Neo4j via ${neo4j_url}`);

// Create an instance of Neo4jGraphQL
const driver = neo4j.driver(
    neo4j_url,
    neo4j.auth.basic(neo4j_user, neo4j_password)
);

const neoSchema = new Neo4jGraphQL({ typeDefs, driver });

// Create an instance of ApolloServer
neoSchema.getSchema().then((schema) => {
    const server = new ApolloServer({
        schema,
    });
  
    server.listen().then(({ url }) => {
        console.log(`🚀 Server ready at ${url}`);
    });
  })