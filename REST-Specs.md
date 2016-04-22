# Specifications
The default data format will be in [JSON](http://www.json.org/) and the json
will be designed according to [JSON API](http://jsonapi.org) specifications.
The data will be exchanged through `http` resources and the endpoints of the
resources will be designed following the restful conventions. The basic
principle of the resource conventions are more or less described in the `JSON
API` website, [here](http://jsonapi.org/recommendations/) and
[here](http://jsonapi.org/format/#fetching).

Here is the basic format of `JSON API` structure, it might or might not contain
all the fields.

### Single resource

```json
{
    "data": {
        "type": "",
        "id": "",
        "attributes": {},
        "relationships": {},
        "links": {},
        "meta": {}
    },
    "included": [],
    "links": {
        "self": {},
        "related": {}
    },
    "jsonapi":{}
}

```

### Resource collection

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
    "jsonapi":{}
}
```

### Error representation

```json
{
    "errors: [{
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



The concept and naming of various resources are created around chado schema modules
and conventions.

# Resources 

## API endpoint

## Controlled vocabulary(cv) or ontology
Resources related to cv(controlled vocabulary)

### `/cvs`
List all cvs. 

#### Response structure

```json
{
    "data": [{
        "type": "cvs",
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
