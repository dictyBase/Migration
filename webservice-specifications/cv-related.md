## `/cvs/:id/cvterms/:id/synonyms` 
## `/cvs/:id/predicates/:id/synonyms`

**Document structure**

```json
{
    "links": {
        "self": "/cvs/eco/cvterms/ECO:9000000/synonyms"
    },
    "data": [
        {
            "type": "synonym",
            "id": "9",
            "attributes": {
                "name": "evidence_code",
                "scope": "RELATED"
            },
            "links": {
                "self": "/cvs/eco/cvterms/ECO:9000000/synonyms/9"
            }
        },
        {
            "type": "synonym",
            "id": "10",
            "attributes": {
                "name": "infered by curator",
                "scope": "EXACT"
            },
            "links": {
                "self": "/cvs/eco/cvterms/ECO:9000001/synonyms/10"
           }
        }
    ]
}
```

For predicate resource replace `cvterms` with `predicates` in the `self` link.

## `/cvs/:id/cvterms/:id/synonyms/:id` 
## `/cvs/:id/predicates/:id/synonyms/:id`

**Document structure**

```json
{
    "links": {
        "self": "/cvs/eco/cvterms/ECO:9000000/synonyms/9"
    },
    "data": {
        "type": "synonym",
        "id": "9",
        "attributes": {
            "name": "evidence_code",
            "scope": "RELATED"
        }
    }
}
```

For predicate resource replace `cvterms` with `predicates` in the `self` link.

## `/cvs/:id/cvterms/:id/relationships/dbxrefs` 
## `/cvs/:id/predicates/:id/relationships/dbxrefs`

**Document structure**

```json
{
    "links": {
        "self": "/cvs/eco/cvterms/ECO:0000006/relationships/dbxrefs"
    },
    {
        "data": [
            {
                "type": "dbxref",
                "id": "GO_REF:0000011",
                "attributes": {
                    "database":"GO_REF",
                    "accession": "0000011"
                },
                "links": {
                    "related": "/dbxrefs/GO_REF:0000011"
                }
            },
            {
                "type": "dbxref",
                "id": "KEGG:R05612",
                "attributes": {
                    "database": "KEGG",
                    "accession": "R05612"
                },
                "links": {
                    "related": "/dbxrefs/KEGG:R05612"
                }

            }
        ]
    }
}
```


## `/dbxrefs`
Will be written later as a part of general module.

## `/dbxrefs/:id`
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
            "attributes": {
                "database": "GO_REF",
                "accession": "0000011"
            }
        }
    }
}

```

## `/cvs/:id/predicates/:id/relationships/objects`
## `/cvs/:id/predicates/:id/relationships/connected`

**Document structure**
Identical to `/cvs/:id/predicates`. However the response will not be
paginated.

## `/cvs/:id/predicates/:id/objects`
## `/cvs/:id/predicates/:id/connected`
**Allowed methods**
GET

**Document structure**
Identical to `/cvs/:id/predicates`. However the response will not be
paginated.

## `/cvs/:id/predicates/:id/relationships/subjects` 
Identical to ```/cvs/:id/predicates/:id/relationships/objects```

## `/cvs/:id/predicates/:id/subjects`
Identical to ``/cvs/:id/predicates/:id/objects``

## `/cvs/:id/predicates/:id/ancestors` 
## `/cvs/:id/predicates/:id/descendants`
**Allowed methods**
GET

**Document structure**
Identical to `/cvs/:id/predicates`. However the response will be paginated.

