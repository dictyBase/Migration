# Chado properties
There is no independent resource tied to chado property concept. It is more of
a design pattern to represent key value pair constrained by a cv term.
Different resources in chado webservice utilize this pattern to represent
additional data properties that cannot be included in the attributes of the
primary resource. The primary resource will use a **properties** relationship
to create a linked property resource. However, the json structure of every
property resource will be identical.

Since this is not specific for any resource, a generic resource name will
be used here.

## `/:resource/properties/:id`

**Document structure** 

```json
{
    "links": {
        "self": "/:resource/properties/17"
    },
    "data": {
        "type": "chadoprop",
        "id": "17",
        "attributes": {
            "value": "blue"
        },
        "relationships": {
            "proptype": {
                "links": {
                    "related": "/cvs/strain_inventory/cvterms/STRAININVENT:0000003"
                }
            }
        }
    }
}

```

## `/:resource/properties/:id` 

**Document structure**

```json
{
    "links": {
        "self": "/:resource/properties"
    },
    "data": [
        {
            "type": "chadoprop",
            "id": "17",
            "attributes": {
                "value": "blue"
            },
            "relationships": {
                "proptype": {
                    "links": {
                        "related": "/cvs/strain_inventory/cvterms/STRAININVENT:0000003"
                    }
                }
            },
            "links": {
                "self": "/:resource/properties/17"
            }
        },
        {
            "type": "chadoprop",
            "id": "25",
            "attributes": {
                "value": "dictyBase"
            },
            "relationships": {
                "proptype": {
                    "links": {
                        "related": "/cvs/gpad/cvterms/assigned_by"
                    }
                }
            },
            "links": {
                "self": "/:resource/properties/25"
            }
        }
    ]
}

```
