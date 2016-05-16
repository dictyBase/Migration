# Sequence

![sequence_data_model](https://cloud.githubusercontent.com/assets/48740/15254763/15f9331e-18fe-11e6-9e16-c5827869ca52.png)

In the diagram, highlighted relationships(dotted borders) can be manipulated
independently or in JSON API term they will have both **self** and **related**
resource links. It is identical to the concept described both in [API
spec](Webservice-specs.md#self-related-and-http-methods) and [cv related
resource](webservice-specifications/cv-related.md).

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

## `/features/:id/properties`

**Document structure**

It's [here](webservice-specifications/chado-common.md#resourcepropertiesid-1)

## `features/:id/relationships/organism`

**Document structure**

For **POST** and **PATCH**, use [this](webservice-specifications/organism.md#organism) document structure.

## `features/:id/featureanalyses`

**Document structure**

