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
resource.  In cvterms of a graph data structure, **related** is the node and
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
            }                                                   |
                                                                |
        }                                                       |
    },                                                          |  GET
    included: [                                                 |
                                                                |
       <--------------------------------------------------------|
    ]
}
```

### Links and pagination
The `links` field appear in three places in JSON API document. 

* Top level

```json
{
    "data": {},
    "links": {}
}

```
* Inside a resource object

```json
{
    "data": {
        "links": {}
    }
}
```

* Inside a relationship object 

```json 
{
    "data": {
        "relationships": {
            "object": {
                "links": {}
            }
        }
    }
}

```

And putting it all together, 

```json
{
    "data": {
        "relationships": {
            "object": {
                "links": {}
            }
        },
        "links": {}
    },
    "links": {}
}

```

The specification is given [here](http://jsonapi.org/format/#document-links).
In a nutshell, it generally contains two fields `self` and `related`.

```json
{
    "links": {
        "self": "",
        "related": ""
    }
}

```

#### Pagination
The [links](http://jsonapi.org/format/#document-links) object for representing
pagination links. The specification is
[here](http://jsonapi.org/format/#fetching-pagination), particularly how to
represent pagination of primary
[data](http://jsonapi.org/examples/#pagination).The pagination of included
resources, however should be included in the  `links` field of the resource
object. Here is one example taken from
[here](https://github.com/json-api/json-api/pull/462).

```json
{
  "data": [{
    "type": "posts",
    "id": "1",
    "title": "JSON API paints my bikeshed!",
    "links": {
      "self": "http://example.com/posts/1",
      "author": {
        "self": "http://example.com/posts/1/links/author",
        "related": "http://example.com/posts/1/author",
        "linkage": { "type": "people", "id": "9" }
      },
      "comments": {
        "self": "http://example.com/posts/1/comments?page[offset]=2",
        "next": "http://example.com/posts/1/comments?page[offset]=3",
        "last": "http://example.com/posts/1/comments?page[offset]=10",
        "prev": "http://example.com/posts/1/comments?page[offset]=1"
      }
    }
  }
```


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
Unless specified, by default all resources will allow HTTP **GET, POST,
DELETE** and **PATCH** methods. All collection resources by default does not
allow **PATCH** and **DELETE**, only **GET** and **POST** are permitted.

## API endpoint

## Controlled vocabulary(cv) or ontology
Resources related to cv(controlled vocabulary)

### `/cvs`
Resource for collection of cvs. 

**Document structure**

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

**Document structure**

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
            "cvcvterms": {
                "links": {
                    "related": "/cvs/ro/cvcvterms"
                }
            },
            "typedefs": {
                "links": {
                    "related": "/cvs/ro/typedefs"
                }
            }
        },
    },
    "links": {
        "self": "/cvs/ro"
    }
}
```

#### Related resources
Support `cvcvterms` as include parameter. 

```/cvs/:id?include=cvterms```

It will include the term resources for that cv. The list of term resource
objects will be paginated.

**Document structure**

```json
{
    "data": {
        .....
        "links": {
            "cvterms": {
                "self": "",
                "first": "",
                "last": "",
                "previous": "",
                "next": ""
            }
        }
    },
    included: [
        # cvterm resources here
    ]
}
```

### `/cvs/:id/cvterms`

### `/cvs/:id/predicates`

### `/cvs/:id/cvterms/:id`
The syntax of the cvterm `id` is defined [here](http://owlcollab.github.io/oboformat/doc/GO.format.obo-1_4.html#S.1.6).

**Document structure**
```json
{
    "links": {
        "self": "/cvs/eco/cvterms/ECO:0000006"
    }
    "data": {
        "type": "cvterm",
        "id": "ECO:0000006",
        "attributes": {
            "name": "experimental evidence",
            "defintion": "an evidence type that is  based on....""
            "iri": "http://purl.obolibrary.org/obo/ECO_0000006",
            "comment": "It has no comment",
            "alternate_ids": ["ECO:0000014", "ECO:001125"],
            "created_by": "bob",
            "creation_date": "2009-04-13T01:32:36Z",
            "relationships": {
                "synonyms": {
                    "links": {
                        "related": "/cvs/eco/cvterms/ECO:0000006/synonyms"
                    }
                },
                "dbxrefs": {
                    "links": {
                        "related": "/cvs/eco/cvterms/ECO:0000006/dbxrefs"
                    }
                },
                "objects": {
                    "links": {
                        "self": "/cvs/eco/cvterms/ECO:0000006/relationships/objects",
                        "related": "/cvs/eco/cvterms/ECO:0000006/objects"
                    }
                },
                "subjects": {
                    "links": {
                        "self": "/cvs/eco/cvterms/ECO:0000006/relationships/subjects",
                        "related": "/cvs/eco/cvterms/ECO:0000006/subjects"
                    }
                },
                "ancestors": {
                    "links": {
                        "related": "/cvs/eco/cvterms/ECO:0000006/ancestors"
                    }
                },
                "descendants": {
                    "links": {
                        "related": "/cvs/eco/cvterms/ECO:0000006/descendants"
                    }
                },
                "connected": {
                    "links": {
                        "self": "/cvs/eco/cvterms/ECO:0000006/relationships/connected",
                        "related": "/cvs/eco/cvterms/ECO:0000006/connected"
                    }
                }
            }
        }
    }
}

```

### `/cvs/:id/predicates/:id`
Predicates represents the relationship terms(edge labels) in cv. The predicate
id is also expressed in [shorthand
format](https://github.com/oborel/obo-relations/wiki/Identifier://github.com/oborel/obo-relations/wiki/Identifiers).
It is also known as [unprefixed
id](http://owlcollab.github.io/oboformat/doc/obo-syntax.html#5.9.3) and the
formal specification is described
[here](http://owlcollab.github.io/oboformat/doc/obo-syntax.html#2.5)

**Document structure**

```json
{
    "links": {
        "self": "/cvs/eco/predicates/ECO:9000000"
    }
    "data": {
        "type": "cvterm",
        "id": "ECO_9000000",
        "attributes": {
            "name": "used_in",
            "defintion": "use me",
            "iri": "http://purl.obolibrary.org/eco/ECO_9000000",
            "comment": "Think before you use",
            "alternate_ids": ["ECO:0000019", "ECO:9000001"],
            "relationships": {
                "synonyms": {
                    "links": {
                        "self": "/cvs/eco/cvterms/ECO:0000006/relationships/synonyms"
                        "related": "/cvs/eco/cvterms/ECO:0000006/synonyms"
                    }
                },
                "dbxrefs": {
                    "links": {
                        "self": "/cvs/eco/cvterms/ECO:0000006/relationships/dbxrefs"
                        "related": "/cvs/eco/cvterms/ECO:0000006/dbxrefs"
                    }
                },
                "objects": {
                    "links": {
                        "self": "/cvs/eco/cvterms/ECO:0000006/relationships/objects",
                        "related": "/cvs/eco/cvterms/ECO:0000006/objects"
                    }
                },
                "subjects": {
                    "links": {
                        "self": "/cvs/eco/cvterms/ECO:0000006/relationships/subjects",
                        "related": "/cvs/eco/cvterms/ECO:0000006/subjects"
                    }
                },
                "ancestors": {
                    "links": {
                        "related": "/cvs/eco/cvterms/ECO:0000006/ancestors"
                    }
                },
                "descendants": {
                    "links": {
                        "related": "/cvs/eco/cvterms/ECO:0000006/descendants"
                    }
                },
                "connected": {
                    "links": {
                        "self": "/cvs/eco/cvterms/ECO:0000006/relationships/connected",
                        "related": "/cvs/eco/cvterms/ECO:0000006/connected"
                    }
                }
            }
        }
    }
}
```

### `/cvs/:id/cvterms/:id/synonyms`

**Document structure**

```json
{
    "links": {
        "self": "/cvs/eco/cvterms/ECO_9000000/synonyms"
    },
    "data": [
        {
            "type": "synonym",
            "id": "9",
            "name": "evidence_code",
            "scope": "RELATED"
            "links": {
                "self": "/cvs/eco/cvterms/ECO:9000000/synonyms/9"
            }
        }, 
        {
            "type": "synonym",
            "id": "10",
            "name": "infered by curator",
            "scope": "EXACT"
            "links": {
                "self": "/cvs/eco/cvterms/ECO:9000001/synonyms/10"
           }
        }
    ]
}
```

### `/cvs/:id/cvterms/:id/synonyms/:id`

**Document structure**

```json
{
    "links": {
        "self": "/cvs/eco/cvterms/ECO:9000000/synonyms/9"
    },
    "data": {
        "type": "synonym",
        "id": "9",
        "name": "evidence_code",
        "scope": "RELATED"
    }
}
```

### `/cvs/:id/cvterms/:id/dbxrefs"`

**Document structure**

```json 
{
    "links": {
        "self": "/cvs/eco/cvterms/ECO:0000006/dbxrefs"
    },
    {
        "data": [
            {
                "type": "dbxref",
                "id": "GO_REF:0000011",
                "database": "GO_REF",
                "accession": "0000011",
                "links": {
                    "self": "/dbxrefs/GO_REF:0000011"
                }
            }, 
            {
                "type": "dbxref",
                "id": "KEGG:R05612",
                "database": "KEGG",
                "accession": "R05612",
                "links": {
                    "self": "/dbxrefs/KEGG:R05612"
                }

            }
        ]
    }
}
```

### `/dbxrefs/:id"`
The dbxref `id` needs to be url encoded.

**Document structure**

```json
{
    "links": {
        "self": "/dbxrefs/GO_REF:0000011"
    },
    {
        "data": {
            "type": "dbxref",
            "id": "GO_REF:0000011",
            "database": "GO_REF",
            "accession": "0000011"
        }
    }
}

```

