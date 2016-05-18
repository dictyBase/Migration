# Stock center

Resources related to dicty stock center and it's orders

* [`/orders/:order_id`](#order_id)
* [`/orders`](#orders)
* `/stocks/:stock_id`
* `/stocks`
* [`/users/:user_id`](#user_id)
* [`/users`](#users)

<a name="order_id"></a>
## `/orders/:order_id`

Request a single order. Here, the primary data is a *single resource object*

**Allowed HTTP methods**

* GET
* PATCH
* DELETE

The primary data which is a singe resource object, contains the information of a single dsc order. Allowed HTTP methods can be executed at `/orders/:order_id`. For instance, an order with the id 874993 can be retrieved at `/orders/874993` with HTTP GET method.

#### relationships

`stocks` relationship indicates the items ordered (strains, plasmids etc.).

There are three types of users associated with a single order. `consumer`, `payer`, and `purchaser`. It is possible that all three be the same user.

`consumer` : The person(user) who is receiving the stocks in mail.

`payer` : The person(user) who is paying for the stocks.

`purchaser` : The person who is ordering (the logged in user).

### Response Structure

```json
HTTP/1.1 200 OK
Content-Type: application/vnd.api+json

{   
    "data": {
        "type": "order",
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
        "relationships": {
            "stocks": {
                "links": {
                    "self": "/orders/8749937/relationships/stocks",
                    "related": "/orders/8749937/stocks"
                },
                "data": [
                    {"type": "strain", "id": "DBS0238484"},
                    {"type": "plasmid", "id": "DBP0251758"}
                ]
            },
            "consumer": {
                "links": {
                    "self": "/orders/8749937/relationships/consumer",
                    "related": "/users/25"
                },
                "data": {"type": "user", "id": "25"}
            },
            "payer": {
                "links": {
                    "self": "/orders/8749936/relationships/payer",
                    "related": "/users/26"
                },
                "data": {"type": "user", "id": "26"}
            },
            "purchaser": {
                "links": {
                    "self": "/orders/8749937/relationships/purchaser",
                    "related": "/users/27"
                },
                "data": {"type": "user", "id": "27"}
            }
        }
    },
    "links": {"self": "/orders/8749937"}
}
```

<a name="orders"></a>
# `/orders`

List all orders or create an order. Here, the primary data is a *resource collection object*

**Allowed HTTP methods**

* GET
* POST

### GET

List of orderes can be retrieved by sending a GET request to `/orders`

#### Structure of a GET request. 

```json
HTTP/1.1 200 OK
Content-Type: application/vnd.api+json

{   
    "data": [{
        "type": "order",
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
        "type": "order",
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
        "type": "order",
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

#### Structure of a POST request

```json
POST /orders HTTP/1.1
Content-Type: application/vnd.api+json
Accept: application/vnd.api+json

{
  "data": {
    "type": "order",
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
                {"type": "strain", "id": "DBS0238484"},
                {"type": "plasmid", "id": "DBP0251758"}
            ]
        },
        "consumer": {
            "data": {"type": "user", "id": "25"}
        },
        "payer": {
            "data": {"type": "user", "id": "26"}
        },
        "purchaser": {
            "data": {"type": "user", "id": "27"}
        }
    }
  }
}
```


<a name="user_id"></a>
## `/users/:user_id`

Request a single user. Here, primary data is a *single resource object*

**Allowed HTTP methods**

* GET
* PATCH
* DELETE

### Example Response

`GET /users/25`

```json
HTTP/1.1 200 OK
Content-Type: application/vnd.api+json

{
    "data": {
        "type": "user",
        "id": "25",
        "attributes": {
            "first_name": "John",
            "last_name": "Smith",
            "email": "john@gmail.com",
            "organization": "UIC",
            "group": "Bio Infomatics Lab",
            "address" : {"first": "4563 N Michicagn Ave", "second": ""},
            "city": "Chicago",
            "state": "IL",
            "zip": "60625",
            "country": "USA",
            "phone": "312-503-8367"
        }
    },
    "links": {"self": "/users/25"}
},

```

<a name="users"></a>
# `/users`

List all users or create a user. Here, primary data is a *resource collection object*

**Allowed HTTP methods**

* GET
* POST

### GET

List of users can be retrieved by sending a GET request to `/users`

#### Structure of a GET request

```json
HTTP/1.1 200 OK
Content-Type: application/vnd.api+json

{   
    "data": [{
        "type": "user",
        "id": "25",
        "links": {"self": "/users/25"}
    },
    {
        "type": "user",
        "id": "65",
        "links": {"self": "/users/65"}
    },
    {
        "type": "user",
        "id": "10",
        "links": {"self": "/users/10"}
    }],
    "links": {
      "self": "/users?page[number]=1&page[size]=3",
      "first": "/users?page[number]=1&page[size]=3",
      "prev": "",
      "next": "/users?page[number]=2&page[size]=3",
      "last": "/users?page[number]=10&page[size]=2"
    }
}

```

### POST

A single user resource can be created by sending a POST request to `/users`

#### Structure of a POST request

```json
POST /users HTTP/1.1
Content-Type: application/vnd.api+json
Accept: application/vnd.api+json

{
    "data": {
        "type": "user",
        "attributes": {
            "first_name": "John",
            "last_name": "Smith",
            "email": "john@gmail.com",
            "organization": "UIC",
            "group": "Bio Infomatics Lab",
            "address" : {"first": "4563 N Michicagn Ave", "second": ""},
            "city": "Chicago",
            "state": "IL",
            "zip": "60625",
            "country": "USA",
            "phone": "312-503-8367"
        }
    }
},

```

## Error objects

### Strcuture of an error response from the server.

`GET /users/john@gmail.com`

```json
{
  "errors": [
    {
      "status": "404",
      "title":  "Not Found",
      "detail": "User does not exist"
    }
  ]
}

```
