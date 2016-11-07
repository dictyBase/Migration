# Publication

* [/publications/:id ](#publicationid)
* [/publications ](#publications)
* [/authors/:id ](#authorsid)
* [/authors ](#authors)
* [Related resources](#related-resources)
    * [/publications/:id/authors ](#publicationsidauthors)
    * [/publications/:id/relationships/authors ](#publicationsidrelationshipsauthors)


## `/publications/:id`
Resource for a publication. The id will be primarily [pubmed
identifier](https://en.wikipedia.org/wiki/PubMed#PubMed_identifier), however
for handful of non-published resources, internally generated identifiers will
be used. In future, instead
[doi](https://en.wikipedia.org/wiki/Digital_object_identifier) could be used
exclusively.

**Document structure**

```json
{
    "data": {
        "links": {
            "self": "/publications/26099919"
        },
        "type": "publication",
        "id": "26088819",
        "attributes": {
            "doi": "10.1002/dvg.22867",
            "title": "dictyBase 2015: Expanding data and annotations in a new software environment",
            "abstract": "dictyBase is the model organism database ......",
            "journal": "Genesis",
            "year": "2015",
            "volume": "12",
            "pages": "765-80",
            "month": "june",
            "issn": "1526-968X",
        },
        "relationships": {
            "authors": {
                "links": {
                    "self": "/publications/26099919/relationships/authors",
                    "related": "/publication/26099919/authors"
                }
            }
        }
    }
}
```

## `/publications`
It will be a paginated response.

**Document structure**

```
{
    "data": [
        {
            "links": {
                "self": "/publications/26088819"
            }
            "type": "publication",
            "id": "26088819",
            "attributes": {
                "doi": "10.1002/dvg.22867",
                "title": "dictyBase 2015: Expanding data and annotations in a new software environment",
                "abstract": "dictyBase is the model organism database ......",
                "journal": "Genesis",
                "year": "2015",
                "volume": "12",
                "pages": "765-80",
                "month": "june",
                "issn": "1526-968X",
            }
        }, 
        {
            "links": {
                "self": "/publications/23172289"
            }
            "type": "publication",
            "id": "23172289",
            "attributes": {
                "doi": "10.1093/nar/gks1064",
                "title": "dictyBase 2013: Integrating multiple dictyostelid species",
                "abstract": "dictyBase is the model organism database ......",
                "journal": "Nucleic Acids Research",
                "year": "2013",
                "volume": "41",
                "pages": "676-80",
                "month": "jan",
                "issn": "1362-4962",
            }
        }
    ],
    "links": {
        "self": "/publications?page[number]=6&page[size]=10",
        "next": "/publications?page[number]=7&page[size]=10",
        "prev": "/publications?page[number]=5&page[size]=10",
        "last": "/publications?page[number]=80&page[size]=10",
        "first": "/publications?page[number]=1&page[size]=10"
    },
    "meta": {
        "pagination": {
            "records": 800,
            "total": 80,
            "size": 10,
            "number": 6
        }
    }
}

```

## `/authors/:id`

**Document structure**

```json
{
    "data": {
        "links": {
            "self": "/authors/30330"
        },
        "attributes": {
            "last_name": "Rajandream",
            "given_name": "MA",
            "rank": "13"
        },
        "relationships": {
            "publications": {
                "related": "/authors/30330/publications",
                "self": "/authors/30300/relationships/publications"
            }
        }
    }
}
```

## `/authors`

**Document structure**

```json
{
    "data": [
        {
            "links": {
                "self": "/authors/483943"
            },
            "attributes": {
                "last_name": "Wardroper",
                "given_name": "A",
                "rank": "22"
            }
        },
        {
            "links": {
                "self": "/authors/3479343"
            },
            "attributes": {
                "last_name": "Quail",
                "given_name": "MA",
                "rank": "11"
            }
        }
    ],
    "links": {
        "self": "/authors?page[number]=13&page[size]=10",
        "next": "/authors?page[number]=14&page[size]=10",
        "prev": "/authors?page[number]=12&page[size]=10",
        "first": "/authors?page[number]=1&page[size]=10",
        "last": "/authors?page[number]=200&page[size]=10"
    },
    "meta": {
        "pagination": {
            "records": 2000,
            "total": 200,
            "size": 10,
            "number": 13
        }
    }
}

```

## Related resources
* Generic [specifications](http://jsonapi.org/format/#crud-updating-relationships)
* Expected [behaviour](/Webservice-specs.md#self-related-and-http-methods) in this context.

### `/publications/:id/authors` 

**Document structure**

Identical to [authors](/webservice-specifications/publication.md#authors)

### `/publications/:id/relationships/authors`

This resource only allow `POST`, `PATCH` and `DELETE` methods to manage the relationships.

