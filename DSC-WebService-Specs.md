# Stock center

Resources related to dicty stock center and it's orders

* [`/orders/{order_id}`](#order_id)
* [`/orders`](#orders)
* `/stocks/{stock_id}`
* `/stocks`
* [`/users/{user_id}`](#user_id)
* [`/users`](#users)

<a name="order_id"></a>
## `/orders/{order_id}`

Request a single order. Here, the primary data is a *single resource object*

**Allowed HTTP methods**

* GET
* POST
* PATCH
* DELETE

The primary data which is a singe resource object, contains the information of a single dsc order. Allowed HTTP methods can be executed at `/orders/{order_id}`. For instance, an order with the id 874993 can be retrieved at `/orders/874993` with HTTP GET method.

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
            "shipping": {"account": "FedEx", "account_num": "389742"},
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
## `/orders`

List all orders. Here, primary data is a *resource collection object*

**Allowed HTTP methods**

* GET

### Example Response

`GET /orders`

```json
HTTP/1.1 200 OK
Content-Type: application/vnd.api+json

{   
    "data": [{
        "type": "order",
        "id": "8749937",
        "links": {"self": "/orders/8749937"}
    },
    {
        "type": "order",
        "id": "27663",
        "links": {"self": "/orders/27663"}
    },
    {
        "type": "order",
        "id": "546737",
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

A list of all orders can be requested at `/orders`. 

<a name="user_id"></a>
## `/users/{user_id}`

Request a single user. Here, primary data is a *single resource object*

**Allowed HTTP methods**

* GET
* POST
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
            "address" : {"line_1": "4563 N Michicagn Ave", "line_2": ""},
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
## `/users`

List all users. Here, primary data is a *resource collection object*

**Allowed HTTP methods**

* GET

### Example Response

`GET /users`

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
