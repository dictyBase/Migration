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
        "type": "permissions",
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
            "type": "permissions",
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
            "type": "permissions",
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
        "type": "roles",
        "id": "6",
        "attributes": {
            "role": "curator",
            "description": "A role for manipulating data in the database"
        },
        "relationships": {
           "permissions": {
               "links": {
                    "related": "/roles/6/permissions"
               }
           },
           "users": {
                "links": {
                    "related": "/roles/6/users"
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
            "type": "roles",
            "id": "6",
            "attributes": {
                "role": "curator",
                "description": "A role for manipulating data in the database"
            },
            "relationships": {
               "permissions": {
                   "links": {
                        "related": "/roles/6/permissions"
                   }
               },
               "users": {
                    "links": {
                        "related": "/roles/6/users"
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
        "type": "users",
        "id": "25",
        "attributes": {
            "first_name": "John",
            "last_name": "Smith",
            "email": "john@gmail.com",
            "organization": "UIC",
            "group": "Bio Infomatics Lab",
            "first_address" : "4563 N Michicagn Ave", 
            "second_address": "Apt 203",
            "city": "Chicago",
            "state": "IL",
            "zip": "60625",
            "country": "USA",
            "phone": "312-503-8367"
        },
        "relationships": {
            "roles": {
                "links": {
                    "related": "/users/25/roles"
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
    "data": [
        {
            "type": "users",
            "id": "25",
            "attributes": {
                "first_name": "John",
                "last_name": "Smith",
                "email": "john@gmail.com",
                "organization": "UIC",
                "group": "Bio Infomatics Lab",
                "first_address" : "4563 N Michicagn Ave", 
                "second_address": "Apt 4890",
                "city": "Chicago",
                "state": "IL",
                "zip": "60625",
                "country": "USA",
                "phone": "312-503-8367"
            },
            "relationships": {
                "roles": {
                    "links": {
                        "related": "/users/25/roles"
                    }
                }
            },
            "links": {"self": "/users/25"}
        },
        {
            "type": "users",
            "id": "65",
            "attributes": {
                "first_name": "Pale",
                "last_name": "Caboose",
                "email": "caboose@gmail.com",
                "organization": "PTN",
                "group": "Pacific whale group",
                "first_address" : "583 N main street", 
                "second_address": "2nd floor unit 393",
                "city": "Float",
                "state": "HP",
                "zip": "60635",
                "country": "USA",
                "phone": "312-503-9938"
            },
            "relationships": {
                "roles": {
                    "links": {
                        "related": "/users/65/roles"
                    }
                }
            },
            "links": {"self": "/users/65"}
        }
    ],
    "links": {
      "self": "/users?page[number]=6&page[size]=3",
      "first": "/users?page[number]=1&page[size]=3",
      "prev": "/users?page[number]=5&page[size]=3",
      "next": "/users?page[number]=7&page[size]=3",
      "last": "/users?page[number]=10&page[size]=2"
    },
    "meta": {
        "pagination": {
            "records": 160,
            "total": 60,
            "size": 10,
            "number": 6
        }
    }
}

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
