Table of Contents
=================

  * [Specifications](#specifications)
    * [JSON API specifications in a nutshell](#json-api-specifications-in-a-nutshell)
      * [Single resource object](#single-resource-object)
      * [Resource objects collection](#resource-objects-collection)
      * [Resource identifier object](#resource-identifier-object)
      * [Relationships](#relationships)
      * [Self, related and HTTP methods](#self-related-and-http-methods)
      * [Included member](#included-member)
      * [Links and pagination](#links-and-pagination)
        * [Pagination](#pagination)
      * [Error representation](#error-representation)
  * [Resources for chado access](#resources-for-chado-access)
    * [API endpoint](#api-endpoint)
    * [Specifications for webservices](#specifications-for-webservices)


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

### Self, related and HTTP methods
If only **related** field is present and no specific instructions are given,
the **related** resource should allow all HTTP methods. It also means creating
the related source will create the relationships between the resources.  If
both **self** and **related** are present, then the **related** resource needs
to be present or created first before creating the relationship with **self**
resource. In most cases the **related** resource will have an independent
resource url for manipulating it(POST/PATCH/DELETE). The related resource url
will generally allow the GET method only.  And unless the **self** resource
itself does not represent any independent resource object, **GET** method will
not be applied, **POST**, **PATCH** and **DELETE** will be alllowed.


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
[here](https://github.com/json-api/json-api/pull/462). The meta
section(resource level for the included resource) will have information about
pagination. The pagination object will have four fields with integer values.

```json
pagination: {
    "records": 50,
    "total": 5,
    "size": 10,
    "number": 4
}
```

Here is a pagination example with included resources.

```json
{
  "data": [
        {
            "type": "posts",
            "id": "1",
            "title": "JSON API paints my bikeshed!",
            "links": {
              "self": "http://example.com/posts/1",
              "author": {
                "self": "http://example.com/posts/1/links/author",
                "related": "http://example.com/posts/1/author"
              },
              "comments": {
                "self": "http://example.com/posts/1/comments?page[number]=4&page[size]=10",
                "next": "http://example.com/posts/1/comments?page[number]=5&page[size]=10",
                "last": "http://example.com/posts/1/comments?page[number]10=&page[size]=10",
                "prev": "http://example.com/posts/1/comments?page[number]=3&page[size]=10"
              }
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
    ]
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
Unless specified, by default all collection resources allow HTTP **GET** and
**POST**, whereas singular resources allow **GET**, **DELETE** and **PATCH**.

## API endpoint

## Specifications for webservices
* [Controlled vocabulary](webservice-specifications/cv.md)
* [Publication](webservice-specifications/publication.md)
