# Organism

## `/organisms/:id`

**Document structure**

```json
{
    "data": {
        "type": "organism",
        "id": "32",
        "attributes": {
            "genus": "Dictyostelium",
            "species": "discoideum",
            "abbreviation": "D.discoideum",
            "common_name": "dicty",
            "comment": "blah blah blah"
        },
        "relationships": {
            "properties": {
                "links": {
                    "related": "/organisms/:id/properties"
                }
            }
        }
    },
    "links": {
        "self": "/organisms/32"
    }
}
```

-----

## `/organisms`

**Document structure**

```json
{
    "data": [
        {
            "links": {
                "self": "/organisms/32"
            },
            "type": "organism",
            "id": "32",
            "attributes": {
                "genus": "Dictyostelium",
                "species": "discoideum",
                "abbreviation": "D.discoideum",
                "common_name": "dicty",
                "comment": "blah blah blah"
            }
        },
        {
            "links": {
                "self": "/organisms/35"
            },
            "type": "organism",
            "id": "35",
            "attributes": {
                "genus": "Dictyostelium",
                "species": "fasciculatum",
                "abbreviation": "D.fasciculatum",
                "common_name": "fasciculatum",
                "comment": "blah blah blah"
            }
        }
    ],
    "links": {
        "self": "/organisms?page[number]=4&page[size]=10",
        "next": "/organisms?page[number]=5&page[size]=10",
        "prev": "/organisms?page[number]=3&page[size]=10",
        "last": "/organisms?page[number]=20&page[size]=10",
        "first": "/organisms?page[number]=1&page[size]=10"
    },
    "meta": {
        "pagination": {
            "records": 100,
            "total": 10,
            "size": 10,
            "number": 4
        }
    }
}

```

## `/organisms/:id/properties`
## `/organisms/:id/properties/:id`

**Document structure**

Look [here](/webservice-specifications/chado-common.md#chado-properties)
