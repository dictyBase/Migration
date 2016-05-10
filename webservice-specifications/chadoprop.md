# Chado properties
There is no independent resource tied to chado property concept. It is more of
a design pattern to represent key value pair constrained by a cv term.
Different resources in chado webservice utilize this pattern to represent
additional data properties that cannot be included in the attributes of the
primary resource. The primary resource will use a **properties** relationship
to create a linked property resource. However, the json structure of every
property resource will be identical.

## Singular resource

**Document structure**

```json
{
    "data": {
        "type": "chadoprop",
        "id": "17",
        "attributes": {
            "name": "source",
            "value": "Genbank"
        },
        "relationships": {
            
        }
    }
}

```
