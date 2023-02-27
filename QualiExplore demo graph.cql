MATCH (n) DETACH DELETE n;

// Create a node with the label FilterGroup and property "name"
// Store the node in the "goals" variable to reuse it later
CREATE (goals:FilterGroup {name:'Goals', id: apoc.create.uuid()})
// Create a node with the label FilterStatement and its relation to the filter group "goals"

CREATE (fs1:FilterStatement {text:'I want to monitor product quality.', id: apoc.create.uuid()})-[:BELONGS_TO]->(goals)
CREATE (fs2:FilterStatement {text:'I want a digital twin for a production machine.', id: apoc.create.uuid()})-[:BELONGS_TO]->(goals)

CREATE (quality:FilterGroup {name:'Quality', id: apoc.create.uuid()})
CREATE (fs3:FilterStatement {text:'I am concerned my information is erroneous.', id: apoc.create.uuid()})-[:BELONGS_TO]->(quality)

CREATE (sources:FilterGroup {name:'Sources', id: apoc.create.uuid()})
CREATE (fs4:FilterStatement {text:'I want to deploy sensors in my production.', id: apoc.create.uuid()})-[:BELONGS_TO]->(sources)
CREATE (fs5:FilterStatement {text:'I want to install sensors in my products.', id: apoc.create.uuid()})-[:BELONGS_TO]->(sources)
CREATE (fs6:FilterStatement {text:'I want to work with maintenance reports.', id: apoc.create.uuid()})-[:BELONGS_TO]->(sources)
CREATE (fs7:FilterStatement {text:'I want to connect/use a third party tool.', id: apoc.create.uuid()})-[:BELONGS_TO]->(sources)

CREATE (information:FilterGroup {name:'Information', id: apoc.create.uuid()})
CREATE (fs8:FilterStatement {text:'I want to work with time series.', id: apoc.create.uuid()})-[:BELONGS_TO]->(information)
CREATE (fs9:FilterStatement {text:'I want to work with information dashboards.', id: apoc.create.uuid()})-[:BELONGS_TO]->(information)

// Create a node with the label LifeCyclePhase
CREATE (collection_quality:LifeCyclePhase {name:'Collection qualitiy', id: apoc.create.uuid()})
// Generate relationships for related Quality Characteristic Accuracy
CREATE (accuracy:QualityCharacteristic {name:'Accuracy', description:'The information is without syntactic and semantic problems. The information describes the true value of something.', id: apoc.create.uuid()})-[:CONTRIBUTES_TO]->(collection_quality)
// Generate relationships for all related Quality Factors and assign to one filter statement
CREATE (accuracy)<-[:CONTRIBUTES_TO]-(sem_error:QualityFactor {name:'Semantic error', sources:'https://www.sltinfo.com/the-semantic-problem/', id: apoc.create.uuid(),
    description:'The semantic problem is a problem of linguistic processing. It relates to the issue of how spoken utterances are understood and, in particular, how we derive meaning from combinations of speech sounds (words).'
    })-[:RELEVANT_FOR]->(fs1)
// Assign quality factor to second filter statement
CREATE (sem_error)-[:RELEVANT_FOR]->(fs2)
// Continue with next quality factor and assign to filter statement
CREATE (accuracy)<-[:CONTRIBUTES_TO]-(:QualityFactor {name:'Syntactic error', sources:'https://www.sltinfo.com/the-syntactic-problem/', id: apoc.create.uuid(),
    description:'The syntactic problem is a problem of linguistic processing. It concerns the problem of how roles such as subject and object are allocated in sentences and how different meanings are bound together.'
    })-[:RELEVANT_FOR]->(fs1)

// Generate relationships for related Quality Characteristic Consistency
CREATE (consistency:QualityCharacteristic {name:'Consistency', description:'To what extent information is free from contradiction and coherent with other information.', id: apoc.create.uuid()})-[:CONTRIBUTES_TO]->(collection_quality)
CREATE (consistency)<-[:CONTRIBUTES_TO]-(:QualityFactor {name:'Standard application', sources:'', id: apoc.create.uuid(),
    description:'Catalog standards, such as eClass, define how to describe a product. Users that apply it contribute to a coherent view on the products in the platform.'
    })-[:RELEVANT_FOR]->(fs3)

// Application quality
CREATE (application_quality:LifeCyclePhase {name:'Application qualitiy', id: apoc.create.uuid()})
// Generate relationships for related Quality Characteristic Accessibility
CREATE (accessibility:QualityCharacteristic {name:'Accessibility', description:'The information provides an opportunity to be used when needed.', id: apoc.create.uuid()})-[:CONTRIBUTES_TO]->(application_quality)
CREATE (accessibility)<-[:RELEVANT_FOR]-(:QualityFactor {name:'Commercial factors', sources:'', id: apoc.create.uuid(),
    description:'Commercial factors can prevent companies from getting access to the data.'})

