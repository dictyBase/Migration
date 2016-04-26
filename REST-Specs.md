# Specifications
The default data format will be in [JSON](http://www.json.org/) and the json
will be designed according to [JSON API](http://jsonapi.org) specifications.
The data will be exchanged through `http` resources and the endpoints of the
resources will be designed following the restful conventions. The basic
principle of the resource conventions are more or less described in the `JSON
API` website, [here](http://jsonapi.org/recommendations/) and
[here](http://jsonapi.org/format/#fetching).

Here is the basic format and specifications of `JSON API` structure, it might or might not contain
all the fields.

## JSON API specifications in a nutshell
Generally, there are two types of resource representation, [resource
object](http://jsonapi.org/format/#document-resource-objects) and [resource
identifier object](http://jsonapi.org/format/#document-resource-objects).

### Single resource object

```json
{
    "data": {
        "type": "",
        "id": "",
        "attributes": {},
        "relationships": {
            "object_name": {
                "links": {
                    "self": "",
                    "related": ""
                },
                "data": {},
                "meta": {}
            }
        },
        "links": { 
            "self": {}, 
            "related": {},
            "object_name": {}
        }
    },
    "included": [],
    "links": {
        "self": {},
        "related": {}
    },
    "meta": {},
    "jsonapi":{}
}

```

### Resource objects collection

```json
{
    "data": [{
        "type": "",
        "id": "",
        "attributes": {},
        "relationships": {},
        "links": {},
        "meta": {}
    }],
    "included": [],
    "links": {
        "self": {},
        "related": {}
    },
    "meta": {},
    "jsonapi":{}
}
```

### Resource identifier object

```json 
{
    "data": {
        "id": "",
        "type": ""
    }
}
```

### Relationships

```json
    "relationships": {
        "object_name": {
            "links": {
                "self": "",
                "related": ""
            },
            "data": {},
            "meta": {}
        }
    }
```

The relationships specs is described
[here](http://jsonapi.org/format/#document-resource-object-relationships). The
`data` field, if present, generally represents a repsents a [resource
identifier object](###Resource identifier object).  In this context, the
[links](http://jsonapi.org/format/#document-links) object's **self** field
represent the relationship itself, whereas **related** represents the related
resource.  In terms of a graph data structure, **related** is the node and
**self** represent the vertex.  The details are given
[here](http://jsonapi.org/recommendations/#urls-relationships).

### Included member
Contains an array of [resource objects](###Single resource object) and it should represent the object
that could be fetch from the resource(s) specified in the related field of relationship's links member.

```
{
    data : {
        "relationships": {
            "object_name": {
                "data": {},
                "meta": {},
                "links": {
                    "self": "",
                    "related": "http://getme.com/32"  >----------
                }                                               |
            }
                                                            |
        }                                                   |
    },                                                      |  GET
    included: [                                             |
                                                            |
       <----------------------------------------------------|
    ]
}
```

### Links and pagination


### Error representation

```json
{
    "errors": [{
        "id": "",
        "links": {
            "about": ""
        },
        "status": "",
        "code": "",
        "title": "",
        "detail": "",
        "source": {
            "pointer": "",
            "parameter": ""
        },
        "meta": {}
    }]
}
```

# Resources for chado access
The concept and naming of various resources are created around chado schema modules
and conventions.

## API endpoint

## Controlled vocabulary(cv) or ontology
Resources related to cv(controlled vocabulary)

### `/cvs`
Resource for collection of cvs. 

#### Response structure

```json
{
    "data": [{
        "type": "cv",
        "id": 1,
        "attributes": {
        },
        "relationships": {
        },
        "links": {
        },
        "meta": {
        }
    }],
    "included": [],
    "links": {
        "self": {},
        "related": {}
    }
}
```

### `/cvs/:id`
Resource for a particular cv. The `id` will be unique **ontology short name**  as defined is [OLS](http://www.ebi.ac.uk/ols/beta/ontologies)
or the **acronym** defined in [bioportal](http://bioportal.bioontology.org/ontologies?filter=OBO_Foundry)

```json
{
    "data": {
        "type": "cv",
        "id": 1,
        "attributes": {
            "name": "so",
            "defintion": "This is sequence ontology"
        },
        "relationships": {
            "terms": {
                "related": "/cvs/ro/terms"
            }
        },
    },
    "links": {
        "self": "/cvs/ro"
    }
}
```

#### Related resources
Support `terms` as include parameter. 

```/cvs/:id?include=terms```

It will include the term resources for that cv. The list of term resource
objects will be paginated.

```json
{
    "data": {
        .....
        "links": {
            "terms": {
                "self": "",
                "first": "",
                "last": "",
                "previous": "",
                "next": ""
            }
        }
    },
    included: [
        # term resources here
    ]
}
```
