# Publication

## `/publication/:id`
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
        "relationship": {
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

## `/authors/:id`

## Related resources

### `/publications/:id/relationships/authors`

### `/publications/:id/authors` 

