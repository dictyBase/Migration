FORMAT:1A

# Literature
Literature API is to manage literature in chado database.

# Group Publication
Resources related to **publications** in the API.


## Publication [/publications/{publication_id}]
```apib
+ Parameters
    + publication_id: 26099919 (number, required) - The id will be primarily
      [pubmed identifier](https://en.wikipedia.org/wiki/PubMed#PubMed_identifier).
      However for handful of non-published resources, internally generated
      identifiers will be used. 
```

### Retrieve a specific publication [GET]
```apib
+ Request (application/vnd.api+json)

    + Headers  
            Accept: application/vnd.api+json

+ Response 200 (application/vnd.api+json)

    +Body  
            
            {
                "data": {
                    "links": {
                        "self": "/publications/26099919"
                    },
                    "type": "publications",
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
                        "pub_type": "journal_article",
                        "source": "pubmed",
                        "issue": "8",
                        "status": "ppublish"
                    },
                    "relationships": {
                        "authors": {
                            "links": {
                                "related": "/publication/26099919/authors"
                            }
                        }
                    }
                }
            }
```

### Delete a specific publication [DELETE]
```apib
+ Request (application/vnd.api+json)

    + Headers  
            Accept: application/vnd.api+json

+ Response 204
```

### Update a specific publication [PATCH]
```apib
+ Request (application/vnd.api+json)

    + Headers  
            Accept: application/vnd.api+json  

    + Body

            {
                "data": {
                    "type": "publications",
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
                        "pub_type": "journal_article",
                        "source": "pubmed",
                        "issue": "8",
                        "status": "ppublish"
                    }
                }
            }

+ Response 204
```

## Publication collection [/publications?page[number]={pagenum}&page[size]={pagesize}]
```apib
+ Parameters
    + pagenum: `8` (number, optional) - The page number in the collection.  
        + Default: `1`
    + pagesize: `20` (number, optional) - The number of entries in that page.  
        + Default: 10
```

###  List of all publications [GET]
```apib
+ Request (application/vnd.api+json)

    + Headers  
            Accept: application/vnd.api+json

+ Response 200 (application/vnd.api+json)

    +Body  

                {
                    "data": [
                        {
                            "links": {
                                "self": "/publications/26088819"
                            }
                            "type": "publications",
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
                                "source": "pubmed",
                                "issue": "8",
                                "status": "ppublish",
                                "pub_type": "journal_article"
                            },
                            "relationships": {
                                "authors": {
                                    "links": {
                                        "related": "/publication/26088819/authors"
                                    }
                                }
                            }
                        }, 
                        {
                            "links": {
                                "self": "/publications/23172289"
                            }
                            "type": "publications",
                            "id": "23172289",
                            "attributes": {
                                "doi": "10.1093/nar/gks1064",
                                "title": "dictyBase 2013: Integrating multiple dictyostelid species",
                                "abstract": "dictyBase is the model organism database ......",
                                "journal": "Nucleic Acids Research",
                                "year": "2013",
                                "volume": "41",
                                "pages": "676-80",
                                "issue": "18",
                                "month": "jan",
                                "issn": "1362-4962",
                                "source": "pubmed",
                                "status": "epublish",
                                "pub_type": "journal_article"
                            },
                            "relationships": {
                                "authors": {
                                    "links": {
                                        "related": "/publication/23172289/authors"
                                    }
                                }
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

### Create a new publication [POST]
```apib
+ Request (application/vnd.api+json)

    + Headers  
            Accept: application/vnd.api+json

    + Body

            {
                "data": {
                    "type": "publications",
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
                        "pub_type": "journal_article",
                        "source": "pubmed",
                        "issue": "8",
                        "status": "ppublish"
                    }
                }
            }

+ Response 201 (application/vnd.api+json)  

    + Headers  
            Location: /publications/26088819  

    + Body  

            {
                "data": {
                    "links": {
                        "self": "/publications/26099919"
                    },
                    "type": "publications",
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
                        "pub_type": "journal_article",
                        "source": "pubmed",
                        "issue": "8",
                        "status": "ppublish"
                    }
                }
            }
```

# Group Author
The author resources are dependent of publication and are managed as
relationship resource. For details look at generic
[specifications](http://jsonapi.org/format/#crud-updating-relationships) and
expected [behaviour](/Webservice-specs.md#self-related-and-http-methods) in
of this concept.

## Author collection [/publications/{publication_id}/authors]
```apib
+ Parameters
    + publication_id: `26099919` (number, required) - The id will be primarily [pubmed identifier](https://en.wikipedia.org/wiki/PubMed#PubMed_identifier). 
```

### List of authors for a publication [GET]
```apib
+ Request (application/vnd.api+json)

    + Headers  
            Accept: application/vnd.api+json

+ Response 200 (application/vnd.api+json)

    +Body  

            {
                "data": [
                    {
                        "type": "authors",
                        "id": "483493",
                        "links": {
                            "self": "/authors/483943"
                        },
                        "attributes": {
                            "last_name": "Wardroper",
                            "given_names": "A",
                            "rank": "22"
                        }
                        "relationships": {
                            "publication": {
                                "links": {
                                    "related": "/authors/483943/publication"
                                }
                            }
                        }
                    },
                    {
                        "type": "authors",
                        "id": "3479343",
                        "links": {
                            "self": "/authors/3479343"
                        },
                        "attributes": {
                            "last_name": "Quail",
                            "given_names": "MA",
                            "rank": "11"
                        },
                        "relationships": {
                            "publication": {
                                "links": {
                                    "related": "/authors/3479343/publication"
                                }
                            }
                        }
                    }
                ],
                "links": {
                    "self": "/publications/383439/authors"
                }
            }
```

### Add new author for a publication [POST]
```apib
+ Request (application/vnd.api+json)

    + Headers  
            Accept: application/vnd.api+json

    + Body

            {
                "data": {
                    "type": "authors",
                    "attributes": {
                        "last_name": "Wardroper",
                        "given_names": "A",
                        "rank": "22"
                    }
                }
            }

+ Response 201 (application/vnd.api+json)  

    + Headers  
            Location: /authors/58

    + Body  

            {
                "data": {
                    "links": {
                        "self": "/authors/58"
                    }
                    "type": "authors",
                    "attributes": {
                        "last_name": "Wardroper",
                        "given_names": "A",
                        "rank": "22"
                    },
                    "relationships": {
                        "publication": {
                            "links": {
                                "related": "/authors/58/publication"
                            }
                        }
                    }
                }
            }
```

## Author [/authors/{author_id}]
```apib
+ Parameters
    + author_id: 20 (number, required) - The author id.
```

### Update a specific author [PATCH]
```apib
+ Request (application/vnd.api+json)

    + Headers  
            Accept: application/vnd.api+json

    + Body

            {
                "data": {
                    "type": "authors",
                    "attributes": {
                        "last_name": "Oreilly",
                        "given_names": "John",
                        "rank": "2"
                    }
                }
            }

+ Response 204
```

### Delete a specific author [DELETE]
```apib
+ Request (application/vnd.api+json)

    + Headers  
            Accept: application/vnd.api+json

+ Response 204
```
