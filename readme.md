# ATM api

## Installation
To run localy create `.env.development` and `.env.test` from `.env.sample`
Create `docker-compose.yml` file from `docker-compose.yml.sample`

Set same credentials to database in `.env.development` as in `docker-compose.yml`
As database hostname use name of database container.
`docker ps -a` - list of containers

Run `docker-compose build`. When build complete migrate to database run `docker-compose run --rm app hanami db migrate`

# API
## Enedpoint to withdraw money
### Request: `GET /api/banknotes/:amount`
### Response:
```json
{
    "data": [
        {
            "amount": 2,
            "dimension": 50
        },
        {
            "amount": 1,
            "dimension": 25
        },
        {
            "amount": 2,
            "dimension": 10
        },
        {
            "amount": 1,
            "dimension": 2
        }
    ]
}
```

`dimention` - banknote nominal
`amount` - number of banknotes with current nominal

Errors:
```json
{
    "error": {
        "status": 400,
        "title": "Not enough money in ATM",
        "meta": []
    }
}
```

## Add money to ATM
### Request: `POST /api/banknotes`
```json
{
  "banknotes": [
    {
      "dimension": 10,
      "amount": 2
    },
    {
      "dimension": 50,
      "amount": 1
    },
    {
      "dimension": 5,
      "amount": 25
    }
  ]
}
```

### Response:
```json
{
    "data": [
        {
            "amount": 14,
            "dimension": 10
        },
        {
            "amount": 7,
            "dimension": 50
        },
        {
            "amount": 175,
            "dimension": 5
        }
    ]
}
```

Errors:
```json
{
    "error": {
        "status": 422,
        "title": "Validation error",
        "meta": {
            "banknotes": {
                "0": {
                    "dimension": [
                        "must be one of: 1, 2, 5, 10, 25, 50"
                    ]
                },
                "1": {
                    "amount": [
                        "is missing"
                    ]
                }
            }
        }
    }
}
```
