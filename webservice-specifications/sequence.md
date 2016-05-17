# Sequence

![sequence_data_model](https://cloud.githubusercontent.com/assets/48740/15254763/15f9331e-18fe-11e6-9e16-c5827869ca52.png)

In the diagram, highlighted relationships(dotted borders) can be manipulated
independently or in JSON API term they will have both **self** and **related**
resource links. It is identical to the concept described both in [API
spec](Webservice-specs.md#self-related-and-http-methods) and [cv related
resource](webservice-specifications/cv-related.md).

* [/features/:id ](#featuresid)
* [/features ](#features)
* [Related resources](#related-resources)
    * [/features/:id/dbxrefs ](#featuresiddbxrefs)
    * [/features/:id/location ](#featuresidlocation)
    * [/features/:id/properties ](#featuresidproperties)
    * [features/:id/relationships/organism ](#featuresidrelationshipsorganism)
    * [/features/:id/analyses/:id ](#featuresidanalysesid)
    * [features/:id/featureanalyses ](#featuresidfeatureanalyses)
    * [analysis](analysis.md)
    * [/features/:id/annotations ](#featuresidannotations)
    * [/features/:id/relationships/phenotypes ](#featuresidrelationshipsphenotypes)
    * [/features/:id/phenotypes ](#featuresidphenotypes)
    * [/features/:id/relationships/publications ](#featuresidrelationshipspublications)
    * [/features/:id/publications ](#featuresidpublications)
    * [/features/:id/relationships/objects ](#featuresidrelationshipsobjects)
    * [/features/:id/relationships/subjects ](#featuresidrelationshipssubjects)
    * [/features/:id/objects ](#featuresidobjects)
    * [/features/:id/subjects ](#featuresidsubjects)
    * [/features/:id/synonyms/:id ](#featuresidsynonymsid)
    * [/features/:id/synonyms ](#featuresidsynonyms)


## `/features/:id`

**Document structure**

```json
{
    "links": {
        "self": "/features/DDB_G028851"
    },
    "data": {
        "type": "gene",
        "id": "DDB_G028851",
        "attributes": {
            "name": "sadA",
            "residues": "ATGC...",
            "lenght": "10",
            "checksum": "3843fjwei",
            "obsolete": "false",
            "analysis": "false",
            "version": "2"
        },
        "relationships": {
            "primary_identifier": {
                "links": {
                    "related": "/dbxrefs/8626671"
                }
            },
            "secondary_identifiers": {
                "links": {
                    "related": "/features/DDB_G028851/dbxrefs"
                }
            },
            "location": {
                "links": {
                    "related": "/features/DDB_G028851/location"
                }
            },
            "properties": {
                "links": {
                    "related": "/feature/DDB_G028851/properties"
                }
            },
            "organism": {
                "links": {
                    "self": "/features/DDB_G028851/relationships/organism",
                    "related": "/organism/18"
                }
            },
            "featureanalysis": {
                "links": {
                    "related": "/features/DDB_G028851/featureanalyses"
                }
            },
            "synonyms": {
                "links": {
                    "related": "/feature/DDB_G028851/synonyms"
                }
            },
            "annotations": {
                "links": {
                    "related": "/feature/DDB_G028851/annotations"
                }
            },
            "phenotypes": {
                "links": {
                    "self": "/features/DDB_G028851/relationships/phenotypes",
                    "related": "/features/DDB_G028851/phenotypes"
                }
            },
            "publications": {
                "links": {
                    "self": "/features/DDB_G028851/relationships/publications",
                    "related": "/features/DDB_G028851/publications"
                }
            },
            "objects": {
                "links": {
                    "self": "/features/DDB_G028851/relationships/objects",
                    "related": "/features/DDB_G028851/objects"
                }
            },
            "subjects": {
                "links": {
                    "self": "/features/DDB_G028851/relationships/subjects",
                    "related": "/features/DDB_G028851/subjects"
                }
            }
        }
    }
}
```

## `/features`

**Document structure**

```json
{
    "links": {
        "self": "/features?page[number]=10&page[size]=10",
        "next": "/features?page[number]=11&page[size]=10",
        "prev": "/features?page[number]=9&page[size]=10",
        "last": "/features?page[number]=250&page[size]=10",
        "first": "/features?page[number]=1&page[size]=10"

    },
    "data": [
        {
            "type": "gene",
            "id": "DDB_G028851",
            "attributes": {
                # as given in /feature
            },
            "links": {
                "self": "/features/DDB_G028851"
            }
        },
        {
            "type": "chromosome",
            "id": "DDB4893433",
            "attributes": {
                ...
            },
            "links": {
                "self": "/features/DDB4893433"
            }
        }
    ],
    "meta": {
        "pagination": {
            "records": 50000,
            "total": 5000,
            "size": 10,
            "number": 10
        }
    }
}
```

## Related resources

### `/features/:id/dbxrefs`

**Document structure**

It's [here](/webservice-specifications/cv-related.md#dbxrefs)

### `/features/:id/location`

**Document structure**

```json
{
    "links": {
        "self": "/features/DDB_G028851/location"
    },
    "data": {
        "type": "location",
        "id": "18",
        "attributes": {
            "minimum": 28,
            "maximum": 340,
            "partial_minimum": "false",
            "partial_maximum": "false",
            "strand": "-1",
            "phase": "0",
            "alternate_residues": "",
            "locus_group": "0",
            "rank": "0"
        },
        "relationships": {
            "source_feature": {
                "links": {
                    "related": "/features/DDB4893433"
                }
            }
        }
    }
}

```

### `/features/:id/properties`

**Document structure**

It's [here](webservice-specifications/chado-common.md#resourcepropertiesid-1)

### `features/:id/relationships/organism`

**Document structure**

For **POST** and **PATCH**, use [this](webservice-specifications/organism.md#organism) document structure.

### `/features/:id/analyses/:id`

**Document structure**

```json
{
    "links": {
        "self": "/features/DDB_G028851/analyses/22"
    },
    "data": {
        "type": "feature_analysis",
        "id": "16",
        "attributes": {
            "raw_score": "1.66",
            "normal_score": "8.98",
            "significance": "7.5",
            "identitiy": "78"
        },
        "relationships": {
            "analysis": {
                "links": {
                    "related": "/analyses/6"
                }
            }
        }
    }
}

```

### `features/:id/featureanalyses`

Related [analysis](webservice-specifications/analysis.md) resources.

**Document structure**

```json
{
    "links": {
        "self": "/features/DDB_G028851/featureanalyses"
    },
    "data": [
        {
            "links": {
                "self": "/features/DDB_G028851/analyses/22"
            },
            "type": "feature_analysis",
            "id": "22",
            "attributes": {
                .....
            }
        },
        {
            "links": {
                "self":  "/features/DDB4893433/analyses/39"
            },
            "type": "feature_analysis",
            "id": "39",
            "attributes": {
                ....
            }
        }
    ]
}
```

### `/features/:id/annotations`

**Allowed methods**

GET only

**Document structure**

It should be a collection resource for a single annotation resource.
Will be done after that is completed.


### `/features/:id/relationships/phenotypes`

**Document structure**

For modifying the resource

```json
{
    "data": [
        { "type": "phenotype", id: "13"},
        { "type": "phenotype", id: "18"}
    ]
}
```

### `/features/:id/phenotypes`

**Document structure**

Identical to phenotype collection resource. Will be shown after its completion.

### `/features/:id/relationships/publications`

**Document structure**

For modifying the resource

```json
{
    "data": [
        { "type": "publication", id: "13"},
        { "type": "publication", id: "39"}
    ]
}
```

### `/features/:id/publications`

**Document structure**

Identical to [publication](webservice-specifications/publication.md#publications) collection resource.

### `/features/:id/relationships/objects`
### `/features/:id/relationships/subjects`

**Allowed methods**

GET,POST,PATCH and delete

**Document structure**

Identical to [predicates](webservice-specifications/cv.md#cvsidpredicates).
The predicates will only be from [relations
ontology](http://www.obofoundry.org/ontology/ro.html).

### `/features/:id/objects`
### `/features/:id/subjects`

**Document structure**

Parent features, identical to feature collection resource.

### `/features/:id/synonyms/:id`

**Document structure**

```
{
    "links": {
        "self": "/features/DDB4893433/synonyms/21"
    },
    "data": {
        "type": "synonym",
        "id": "21",
        "attributes": {
            "name": "foo",
            "encoded_name": "foo",
            "official": "true",
            "internal": "false"
        },
        "relationships": {
            "publication": {
                "links": {
                    "related": "/publications/56"
                }
            }
        }
    }
}
```

### `/features/:id/synonyms`

**Document structure**

```json
{
    "links": {
        "self": "/features/DDB4893433/synonyms"
    },
    "data": [
        {
            "type": "synonym",
            "id": "11",
            "attributes": {
                .....
            },
            "links": {
                "self": "/features/DDB4893433/synonyms/11"
            }
        },
        {
            "type": "synonym",
            "id": "20",
            "attributes": {
                .....
            },
            "links": {
                "self": "/features/DDB4893433/synonyms/20"
            }
        }
    ]
}
```
