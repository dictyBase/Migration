# Analysis

* [/analyses/:id ](#analysesid)
* [/analyses ](#analyses)
* [/analyses/:id/features/:id ](#analysesidfeaturesid)
* [/analyses/:id/features ](#analysesidfeatures)


## `/analyses/:id`

**Document structure**

```json
{
    "links": {
        "self": "/analyses/38"
    },
    "data": {
        "type": "analysis",
        "id": "38",
        "attributes": {
            "name": "dictybase-tblast",
            "description": "analysis using blast",
            "program": "tblastn",
            "programversion": "1.4.6",
            "algorithm": "blast",
            "source_name": "discoideum polypeptide",
            "source_version": "1.2",
            "source_uri": ""
        },
        "relationships": {
            "analysis_features": {
                "links": {
                    "related": "/analyses/38/features"
                }
            },
            "properties": {
                "links": {
                    "related": "/analyses/38/properties"
                }
            }
        }
    }
}
```

## `/analyses`

**Document structure**

```json
{
    "links": {
        "self": "/analyses"
    },
    "data": [
        {
            "links": {
                "self": "/analyses/16"
            },
            "type": "analysis",
            "id": "16",
            "attributes": {
                .....
            }
        },
        {
            "links": {
                "self": "/analyses/3"
            },
            "type": "analysis",
            "id": "3",
            "attributes": {
                ....
            }
        }
    ]
}
```

## `/analyses/:id/features/:id`

**Document structure**

``json
{
    "links": {
        "self": "/analyses/12/features/DDB_G028851"
    },
    "data": {
        "type": "analysis_feature",
        "id": "16",
        "attributes": {
            "raw_score": "1.66",
            "normal_score": "8.98",
            "significance": "7.5",
            "identitiy": "78"
        },
        "relationships": {
            "feature": {
                "links": {
                    "related": "/features/DDB_G028851"
                }
            }
        }
    }
}

``

## `/analyses/:id/features`

**Document structure**

```json
{
    "links": {
        "self": "/analyses/5/features?page[number]=12&page[size]=10",
        "next": "/analyses/5/features?page[number]=13&page[size]=10",
        "prev": "/analyses/5/features?page[number]=11&page[size]=10",
        "last": "/analyses/5/features?page[number]=500&page[size]=10",
        "first": "/analyses/5/features?page[number]=1&page[size]=10"
    },
    "data": [
        {
            "links": {
                "self": "/analyses/5/features/DDB_G028851"
            },
            "type": "analysis_feature",
            "id": "15",
            "attributes":  {
                .....
            }
        },
        {
            "links": {
                "self": "/analyses/5/features/DDB4893433"
            },
            "type": "analysis_feature",
            "id": "20",
            "attributes":  {
                .....
            }
        }
    ],
    "meta": {
        "pagination": {
            "records": 5000,
            "total": 500,
            "size": 10,
            "number": 12
        }
    }
}
```
