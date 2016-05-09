# Relationships
![cvterm_data_model_rel](https://cloud.githubusercontent.com/assets/48740/14989359/03f5d142-111d-11e6-98b8-834a37453577.png)

In the diagram above, relationships highlighted with bordered line represents
independent resources. They can be manipulated(create, edit, delete) without
affecting the related resources. To handle these resources, the related
resources either has to exist or have to be created first. Then the
relationship resource is created to create the connection.

For example, to create the *subject* relation, 
```
GET /cvs/:id/cvterms/:id
    OR
POST /cvs/:id/cvterms
```
After that handle the relationship,
```
POST /cvs/:id/cvterms/:id/relationships/subjects
```

On the other hand, the rest of them(not
highlighted) are manipulated along with the related resources.

And for the allowed HTTP methods(and explanations) see [here](/Webservice-specs.md#self-related-and-http-methods)

## Available resources

* [/cvs/:id/cvterms/:id/synonyms ](#cvsidcvtermsidsynonyms)
* [/cvs/:id/predicates/:id/synonyms ](#cvsidpredicatesidsynonyms)
* [/cvs/:id/cvterms/:id/synonyms/:id ](#cvsidcvtermsidsynonymsid)
* [/cvs/:id/predicates/:id/synonyms/:id ](#cvsidpredicatesidsynonymsid)
* [/cvs/:id/cvterms/:id/relationships/dbxrefs ](#cvsidcvtermsidrelationshipsdbxrefs)
* [/cvs/:id/predicates/:id/relationships/dbxrefs ](#cvsidpredicatesidrelationshipsdbxrefs)
* [/dbxrefs ](#dbxrefs)
* [/dbxrefs/:id ](#dbxrefsid)
* [/cvs/:id/predicates/:id/relationships/objects ](#cvsidpredicatesidrelationshipsobjects)
* [/cvs/:id/predicates/:id/relationships/subjects ](#cvsidpredicatesidrelationshipssubjects)
* [/cvs/:id/predicates/:id/relationships/connected ](#cvsidpredicatesidrelationshipsconnected)
* [/cvs/:id/cvterms/:id/relationships/objects ](#cvsidcvtermsidrelationshipsobjects)
* [/cvs/:id/cvterms/:id/relationships/subjects ](#cvsidcvtermsidrelationshipssubjects)
* [/cvs/:id/predicates/:id/objects ](#cvsidpredicatesidobjects)
* [/cvs/:id/predicates/:id/subjects ](#cvsidpredicatesidsubjects)
* [/cvs/:id/predicates/:id/connected ](#cvsidpredicatesidconnected)
* [/cvs/:id/predicates/:id/ancestors ](#cvsidpredicatesidancestors)
* [/cvs/:id/predicates/:id/descendants ](#cvsidpredicatesiddescendants)
* [/cvs/:id/cvterms/:id/objects ](#cvsidcvtermsidobjects)
* [/cvs/:id/cvterms/:id/subjects ](#cvsidcvtermsidsubjects)
* [/cvs/:id/cvterms/:id/connected ](#cvsidcvtermsidconnected)
* [/cvs/:id/cvterms/:id/ancestors ](#cvsidcvtermsidancestors)
* [/cvs/:id/cvterms/:id/descendants ](#cvsidcvtermsiddescendants)

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

----

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

----



## `/cvs/:id/cvterms/:id/dbxrefs` 
## `/cvs/:id/predicates/:id/dbxrefs`

**Document structure**

```json
{
    "links": {
        "self": "/cvs/eco/cvterms/ECO:0000006/relationships/dbxrefs"
    },
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
```
----

## `/cvs/:id/cvterms/:id/relationships/dbxrefs` 
## `/cvs/:id/predicates/:id/relationships/dbxrefs`

For manipulating the relationships between the cvterm/predicate and dbxrefs.
The resource behaviour is identical to given in JSON AP
[specification](http://jsonapi.org/format/#crud-updating-relationships).


----

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
    "data": {
        "type": "dbxref",
        "id": "GO_REF:0000011",
        "attributes": {
            "database": "GO_REF",
            "accession": "0000011"
        }
    }
}
```
-----

## `/cvs/:id/predicates/:id/relationships/objects`
## `/cvs/:id/predicates/:id/relationships/subjects` 
## `/cvs/:id/predicates/:id/relationships/connected`
## `/cvs/:id/cvterms/:id/relationships/objects`
## `/cvs/:id/cvterms/:id/relationships/subjects`

Here bunch of resources have similar data structure specification. For
**predicates**, the relationships `subject`, `object` and `connected` all are linked to other
predicates, whereas `subjects` and `objects` relationships of *cvterms* are linked through
other **predicates**.
 
**Document structure**

Identical to [/cvs/:id/predicates](cv.md#cvsidpredicates). However the response will not be
paginated.

----

## `/cvs/:id/predicates/:id/objects`
## `/cvs/:id/predicates/:id/subjects`
## `/cvs/:id/predicates/:id/connected`

**Allowed methods**

GET

**Document structure**

Identical to [/cvs/:id/predicates](cv.md#cvsidpredicates). However the response will not be
paginated.

----

## `/cvs/:id/predicates/:id/ancestors` 
## `/cvs/:id/predicates/:id/descendants`
**Allowed methods**
GET

**Document structure**
Identical to [/cvs/:id/predicates](cv.md#cvsidpredicates). However the response will be paginated.

----

## `/cvs/:id/cvterms/:id/objects`
## `/cvs/:id/cvterms/:id/subjects`
## `/cvs/:id/cvterms/:id/connected`

**Allowed methods**

GET

**Document structure**

Identical to [/cvs/:id/cvterms](cv.md#cvsidcvterms). However the response will not be
paginated.

----

## `/cvs/:id/cvterms/:id/ancestors` 
## `/cvs/:id/cvterms/:id/descendants`
**Allowed methods**
GET

**Document structure**
Identical to [/cvs/:id/cvterms](cv.md#cvsidcvterms). However the response will be paginated.
