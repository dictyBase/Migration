# Stock center

  * [/orders/:order_id ](#ordersorder_id)
      * [relationships](#relationships)
  * [/orders ](#orders)
      * [GET](#get)
      * [POST](#post)
  * [/phenotypes/:id ](#phenotypesid)
  * [/phenotypes ](#phenotypes)
  * [/phenotypes/:id/properties/:id ](#phenotypesidpropertiesid)
  * [/phenotypes/:id/properties ](#phenotypesidproperties)
  * [/phenotypes/:id/phenstatements ](#phenotypesidphenstatements)
  * [/genotypes/:id ](#genotypesid)
  * [/genotypes ](#genotypes)
  * [/phenstatements/:id ](#phenstatementsid)
  * [/phenstatements ](#phenstatements)
  * [/stocks/:id ](#stocksid)
  * [/stocks ](#stocks)
  * [/stocks/:id/characteristics ](#stocksidcharacteristics)
  * [/stocks/:id/inventories ](#stocksidinventories)
  * [/stocks/:id/parents ](#stocksidparents)
  * [/stocks/:id/publications ](#stocksidpublications)



## `/orders/:order_id`

Request a single order. Here, the primary data is a *single resource object*

**Allowed HTTP methods**

* GET
* PATCH
* DELETE

The primary data which is a singe resource object, contains the information of a single dsc order. Allowed HTTP methods can be executed at `/orders/:order_id`. For instance, an order with the id 874993 can be retrieved at `/orders/874993` with HTTP GET method.

### Relationships

`stocks` relationship indicates the items ordered (strains, plasmids etc.).

There are three types of users associated with a single order. `consumer`, `payer`, and `purchaser`. It is possible that all three be the same user.

`consumer` : The person(user) who is receiving the stocks in mail.

`payer` : The person(user) who is paying for the stocks.

`purchaser` : The person who is ordering (the logged in user).

__Document structure__

```json
{   
    "data": {
        "type": "orders",
        "id": "8749937",
        "attributes": {
            "created_at": "2015-05-22T14:56:29.000Z",
            "updated_at": "2015-05-22T14:56:29.000Z",
            "courier": "FedEx",
            "courier_account": "34839439",
            "comments": "Whatever whatever",
            "payment": "Credit", 
			"purchase_order_num": "8394398493",
            "status": "Shipped"
        },
        "relationships": {
            "stocks": {
                "links": {
                    "related": "/orders/8749937/stocks"
                },
            },
            "consumer": {
                "links": {
                    "related": "/users/25"
                },
            },
            "payer": {
                "links": {
                    "related": "/users/26"
                },
            },
            "purchaser": {
                "links": {
                    "related": "/users/27"
                }
            }
        }
    },
    "links": {"self": "/orders/8749937"}
}
```

# `/orders`

List all orders or create an order. Here, the primary data is a *resource collection object*

**Allowed HTTP methods**

* GET
* POST

### GET

List of orderes can be retrieved by sending a GET request to `/orders`

__Document structure__

```json
{   
    "data": [{
        "type": "orders",
        "id": "8749937",
        "attributes": {
            "created": "2015-05-22T14:56:29.000Z",
            "shipping": {
                "account": "FedEx",
                "account_num": "389742",
                "comments": ""
            },
            "payment": {"method": "Credit", "purchase_order": ""},
            "status": "Shipped"
        },
        "links": {"self": "/orders/8749937"}
    },
    {
        "type": "orders",
        "id": "27663",
        "attributes": {
            "created": "2014-11-41T11:51:29.000Z",
            "shipping": {
                "account": "UPS",
                "account_num": "28744",
                "comments": ""
            },
            "payment": {"method": "Wire", "purchase_order": ""},
            "status": "in Preparation"
        },
        "links": {"self": "/orders/27663"}
    },
    {
        "type": "orders",
        "id": "546737",
        "attributes": {
            "created": "2016-04-26T01:16:29.000Z",
            "shipping": {
                "account": "FedEx",
                "account_num": "4544",
                "comments": ""
            },
            "payment": {"method": "Credit", "purchase_order": ""},
            "status": "Shipped"
        },
        "links": {"self": "/orders/546737"}
    }],
    "links": {
      "self": "/orders?page[number]=3&page[size]=3",
      "first": "/orders?page[number]=1&page[size]=3",
      "prev": "/orders?page[number]=2&page[size]=3",
      "next": "/orders?page[number]=4&page[size]=3",
      "last": "/orders?page[number]=12&page[size]=2"
    }
}
```

### POST

A single order resource can be created by sending a POST request to `/orders`

__Document structure__

```json

{
  "data": {
    "type": "orders",
    "attributes": {
        "created": "2015-05-22T14:56:29.000Z",
        "shipping": {
            "account": "FedEx",
            "account_num": "389742",
            "comments": ""
        },
        "payment": {"method": "Credit", "purchase_order": ""},
        "status": "Shipped"
    },
    "relationships": {
        "stocks": {
            "data": [
                {"type": "strains", "id": "DBS0238484"},
                {"type": "plasmids", "id": "DBP0251758"}
            ]
        },
        "consumer": {
            "data": {"type": "users", "id": "25"}
        },
        "payer": {
            "data": {"type": "users", "id": "26"}
        },
        "purchaser": {
            "data": {"type": "users", "id": "27"}
        }
    }
  }
}
```

## `/orders/:id/stocks`

__Document structure__

Identical to [/stocks](#stocks)

## `/phenotypes/:id`

__Document structure__

```json
{
    "links": {
        "self": "/phenotypes/DSC_PHEN0007441"
    },
    "data": {
        "type": "phenotypes",
        "id": "DSC_PHEN0007441",
        "attributes": {
            "name": "D.discoideum unique phenotypes",
            "observation": "abolished aggreation",
            "phen_attribute": "decreased occurence",
            "value": "For some reason very less aggreation",
            "cvalue": "I do not know",
            "evidence": "fruiting body development"
        },
        "relationships": {
            "properties": {
                "links": {
                    "related": "/phenotypes/DSC_PHEN0007441/properties"
                }
            }
        }
    }
}
```

## `/phenotypes`

__Document structure__

```json
{
   "links": {
        "self": "/phenotypes?page[number]=5&page[size]=10",
        "next": "/phenotypes?page[number]=6&page[size]=10",
        "prev": "/phenotypes?page[number]=4&page[size]=10",
        "first": "/phenotypes?page[number]=1&page[size]=10",
        "last": "/phenotypes?page[number]=50&page[size]=10"
   },
   "data": [
        {
            "links": {
                "self": "/phenotypes/DSC_PHEN0007441"
            },
            "type": "phenotypes",
            "id": "DSC_PHEN0007441",
            "attributes": {
                "name": "D.discoideum unique phenotypes",
                "observation": "abolished aggreation",
                "phen_attribute": "decreased occurence",
                "value": "For some reason very less aggreation",
                "cvalue": "I do not know",
                "evidence": "fruiting body development"
            },
            "relationships": {
                "properties": {
                    "links": {
                        "related": "/phenotypes/DSC_PHEN0007441/properties"
                    }
                },
                "phenstatements": {
                    "links": {
                        "related": "/phenotypes/DSC_PHEN0007441/phenstatements"
                    }
                }
            }
        }, 
        {
            ....
        }
    ],
    "meta": {
        "pagination": {
            "records": 1000,
            "total": 100,
            "size": 10,
            "number": 5
        }
    }
}
```


## `/phenotypes/:id/properties/:id`

__Document structure__

```json
{
    "links": {
        "self": "/phenotypes/properties/3"
    },
    "data": {
        "type": "chadoprops",
        "id": "3",
        "attributes": {
            "value": "cheater mutant mixed with AX4"
        },
        "relationships": {
            "proptype": {
                "links": {
                    "related": "/cvs/dicty_stockcenter/cvterms/curator note"
                }
            }
        }
    }
}

```

## `/phenotypes/:id/properties`

__Document structure__

It’s a collection resource for the previous line and should be identical to the one given [here](chado-common.md).

## `/phenotypes/:id/phenstatements`

__Document structure__

Identical to [/phenstatements](#phenstatements) 

## `/genotypes/:id`

__Document structure__

```json
{
    "links": {
        "self": "/genotypes/DSC_G0122502"
    },
    "data": {
        "type": "genotypes",
        "id": "DSC_G0122502",
        "attributes": {
            "name": "axeA1,axeB1,axeC1,pB18-cAR1],neoR",
            "description": "Important genotypes" 
        },
        "relationships": {
            "properties": {
                "links": {
                    "related": "/genotypes/DSC_G0122502/properties"
                }
            }
        }
    }
}
```

## `/genotypes`

__Document structure__
```json
{
    "data": [
        {
            "type": "genotypes",
            "id": "DSC_G0122502",
            "attributes": {
                "name": "axeA1,axeB1,axeC1,pB18-cAR1],neoR",
                "description": "Important genotypes" 
            },
            "relationships": {
                "properties": {
                    "links": {
                        "related": "/genotypes/DSC_G0122502/properties"
                    }
                }
            }
        }
        {
            #another genotypes
        }
    ],
    "links": {
        "self": "/genotypes?page[number]=5&page[size]=10",
        "next": "/genotypes?page[number]=6&page[size]=10",
        "prev": "/genotypes?page[number]=4&page[size]=10",
        "first": "/genotypes?page[number]=1&page[size]=10",
        "last": "/genotypes?page[number]=50&page[size]=10"
    },
    "meta": {
        "pagination": {
            "records": 1000,
            "total": 100,
            "size": 10,
            "number": 5
        }
    }
}

```
## `/phenstatements/:id`

## `/phenstatements`

## `/stocks/:id`

There could be two types, strains or plasmid.

__Document structure__

```json
{
   "links": {
        "self": "/stocks/DBS0236225"
   },
   "data": {
        "type": "strains",
        "id": "DBS0236225",
        "attributes": {
            "name": "HL27",
            "description": "partial stalky mutant in marked strains"
        },
        "relationships": {
            "dbxrefs": {
                "links": {
                    "related": "/stocks/DBS0236225/dbxrefs"
                }
            },
            "phenotypes": {
                "links": {
                    "related": "/stocks/DBS0236225/phenotypes"
                }
            },
            "genotypes": {
                "links": {
                    "related": "/stocks/DBS0236225/genotypes"
                }
            },
            "characteristics": {
                "links": {
                    "related": "/stocks/DBS0236225/characteristics"
                }
            },
            "inventories": {
                "links": {
                    "related": "/stocks/DBS0236225/inventories"
                }
            },
            "publications": {
                "links": {
                    "related": "/stocks/DBS0236225/publictions"
                }
            },
            "orders": {
                "links": {
                    "related": "/stocks/DBS0236225/orders"
                }
            },
            "parents": {
                "links": {
                    "related": "/stocks/DBS0236225/parents"
                }
            }
        }
    }
}

```

## `/stocks`

__Document structure__

```json
{
   "data": [
        {
            "type": "stocks",
            "id": "DBS0236225",
            "attributes": {
                "name": "HL27",
                "description": "partial stalky mutant in marked strains",
				"category": "strain"
            },
            "relationships": {
                "dbxrefs": {
                    "links": {
                        "related": "/stocks/DBS0236225/dbxrefs"
                    }
                },
                "phenotypes": {
                    "links": {
                        "related": "/stocks/DBS0236225/phenotypes"
                    }
                },
                "genotypes": {
                    "links": {
                        "related": "/stocks/DBS0236225/genotypes"
                    }
                },
                "characteristics": {
                    "links": {
                        "related": "/stocks/DBS0236225/characteristics"
                    }
                },
                "inventories": {
                    "links": {
                        "related": "/stocks/DBS0236225/inventories"
                    }
                },
                "publications": {
                    "links": {
                        "related": "/stocks/DBS0236225/publictions"
                    }
                },
                "orders": {
                    "links": {
                        "related": "/stocks/DBS0236225/orders"
                    }
                },
                "parents": {
                    "links": {
                        "related": "/stocks/DBS0236225/parents"
                    }
                }
            },
            {
                #another stock item
            }
        ],
    "links": {
      "self": "/stocks?page[number]=3&page[size]=3",
      "first": "/stocks?page[number]=1&page[size]=3",
      "prev": "/stocks?page[number]=2&page[size]=3",
      "next": "/stocks?page[number]=4&page[size]=3",
      "last": "/stocks?page[number]=12&page[size]=2"
    },
    "meta": {
        "pagination": {
            "records": 1000,
            "total": 100,
            "size": 10,
            "number": 3
        }
    }
}

```

## `/stocks/:id/characteristics`

__Document structure__

```json
{
    "links": {
        "self": "/stocks/DBS0236225/characteristics"
    },
    "data": [
        {
           "type": "characteristics",
           "id": "14",
           "attributes": {
               "value": "axenic"
           },
           "relationships": {
               "publication": {
                    "links": {
                        "related": "/publications/573"
                    }
               }
           }
        },
        {
           "type": "characteristic",
           "id": "19",
           "attributes": {
               "value": "neomycin resistant"
           },
           "relationships": {
               "publication": {
                    "links": {
                        "related": "/publications/573"
                    }
               }
           }
        }
    ]
}

```

## `/stocks/:id/inventories`

__Document structure__

```json
{
    "links": {
        "self": "/stocks/DBS0236225/inventories"
    },
    "data": [
        {
           "type": "inventories",
           "id": "7",
           "attributes": {
               "property": "location",
               "value": "2-6(4)"
           }
        },
        {
           "type": "inventory",
           "id": "2",
           "attributes": {
               "property": "no of vials", 
               "value": "4"
           }
        },
        {
           "type": "inventory",
           "id": "4",
           "attributes": {
               "property": "color", 
               "value": "Blue"
           }
        }
    ]
}
```

## `/stocks/:id/parents`

__Document structure__

Identical to [/stocks](#stocks)

## `/stocks/:id/publications`

__Document structure__

Identical to [/publications ](#publications)
