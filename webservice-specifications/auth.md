# Authorization
* [/permissions/:id ](#permissionsid)
* [/permissions ](#permissions)
* [/roles/:id ](#rolesid)
* [/roles/ ](#roles)
* [users](#users)
* [/users/:id ](#usersid)
* [/users ](#users-1)
* [Error objects](#error-objects)


## `/permissions/:id`

__Document structure__

```json
{
    "data": {
        "type": "permission",
        "id": "4",
        "attributes" : {
           "permission": "create-strain",
           "description": "Ability to create strain"
        },
    },
    "links": {
        "self": "/permissions/4"
    }
}
````

## `/permissions`

__Document structure__

```json
{
    "data": [
        {
            "type": "permission",
            "id": "4",
            "attributes": {
               "permission": "create-strain",
               "description": "Ability to create strain"
            },
            "links": {
                "self": "/permissions/4"
            }
        },
        {
            "type": "permission",
            "id": "6",
            "attributes": {
               "permission": "delete-strain",
               "description": "Ability to remove strain"
            },
            "links": {
                "self": "/permissions/6"
            }
        }
    ],
    "links": {
        "self": "/permissions"
    }
}
```

## `/roles/:id`

__Document structure__

```json
{
    "data": {
        "type": "role",
        "id": "6",
        "attributes": {
            "role": "curator",
            "description": "A role for manipulating data in the database"
        },
        "relationships": {
           "permissions": {
               "links": {
                    "related": "/roles/6/permissions",
                    "self": "/roles/6/relationships/permissions",
               }
           },
           "users": {
                "links": {
                    "related": "/roles/6/users",
                    "self": "/roles/6/relationships/users"
                }
           }
        }
    },
    "links": {
        "self": "/roles/6"
    }
}
```

## `/roles/`

__Document structure__

```json
{
    "data": [
        {
            "type": "role",
            "id": "6",
            "attributes": {
                "role": "curator",
                "description": "A role for manipulating data in the database"
            },
            "relationships": {
               "permissions": {
                   "links": {
                        "related": "/roles/6/permissions",
                        "self": "/roles/6/relationships/permissions",
                   }
               },
               "users": {
                    "links": {
                        "related": "/roles/6/users",
                        "self": "/roles/6/relationships/users"
                    }
               }
            },
            "links": { "self": "/roles/6" }
        },
        { ... }
    ],
    "links": { "self": "/roles" }
}
```

## users

This user and roles data structure is not available as HTTP resources, it gets embedded 
as two private claims in `JWT` part of authentication response.

__Document structure__


```json
{
    "roles": [
        {
            "role": "dsc-curator",
            "links": "/roles/6"
        },
        {
            "role": "dsc-orderer",
            "links": "/roles/11"
        },
        {
            "role": "literature-curator",
            "links": "/roles/12"
        },
    ],
    "user": {
        "first_name": "John",
        "last_name": "Smith",
        "email": "john@gmail.com",
        "links": "/users/2"
    }
}
````


## `/users/:id`

__Document structure__

```json
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
        },
        "relationships": {
            "roles": {
                "links": {
                    "related": "/users/25/roles",
                    "self": "/users/25/relationships/roles"
                }
            }
        }
    },
    "links": {"self": "/users/25"}
}

```

## `/users`

__Document structure__

```json
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

A single user resource can be created by sending a POST request to `/users`

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

### Error objects


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
