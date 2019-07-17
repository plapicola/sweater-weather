# Sweater Weather Express

### Introduction

Sweater Weather is designed to a provided specification for integration with a potential future frontend, and is expected to manage a database of users who will be authenticated using a unique API key, make forecast requests for city queries on behalf of authenticated users, and manage favorited locations on behalf of authenticated users.

### How to use

The following dependencies are required:
- Ruby 2.4.1
- Rails 5.2
- PostgreSQL

##### Initial Setup

``` bash
bundle install # Install dependencies
rake db:create
rake db:migrate
```

Additionally, you will be required to obtain API keys for the following services:

- Google Maps
- Dark Sky
- Flickr

These API keys will need to be stored in an `application.yml` file located within the  of the project, with the following format:

```
GOOGLE_GEOCODE_KEY=<YOUR_GOOGLE_MAPS_KEY_HERE>
DARKSKY_KEY=<YOUR_DARKSKY_KEY_HERE>
FLICKR_KEY: <YOUR_FLICKR_KEY_HERE>
FLICKR_SECRET: <YOUR_FLICKR_SECRET_HERE>
```

This file will be parsed by the application using the `figaro` package to load them in to environment variables, and are required for making requests to the Geocoding, Background, and Forecast services.

##### Using the application

Once initial setup is completed the application can be executed using `rails s`.

The application provides the following endpoints:

###### User Creation

New user accounts can be registered via a `POST` request to the `/api/v1/users` endpoint. The request must contain an email (unique in the system), password, and password confirmation matching the format provided below.

``` HTTP
POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "email": "peter@lapicola.com",
  "password": "password",
  "password_confirmation": "password"
}
```

The application will return the API key for the newly created user if the request is successful, along with a status code of 201.

``` HTTP
status: 201
body:

{
  "api_key": "1a46d0f47e622496255c3ed9b08fef67",
}
```

###### User login

Existing users can retrieve their API key by submitting a `POST` request to the endpoint `/api/v1/sessions` with their email and password.

``` HTTP
POST /api/v1/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "peter@lapicola.com",
  "password": "password"
}
```

The application will return the API key for the user if the request is successful, along with a status code of 200.

``` HTTP
status: 200
body:

{
  "api_key": "1a46d0f47e622496255c3ed9b08fef67",
}
```

In the event of a failed request, the application responds with a 401 status code.

###### Requesting a forecast

The application allows users to request forecasts for a location by submitting a `GET` request to the endpoint `/api/v1/forecast`. A query parameter of `location` indicates the desired location for the forecast.

``` HTTP
GET /api/v1/forecast?location=austin,tx
Content-Type: application/json
Accept: application/json

{
  "api_key": "1a46d0f47e622496255c3ed9b08fef67"
}
```

If the request is successful, the application responds with a 200 status, and a forecast object containing the location, current weather, an hourly breakdown, and a daily forecast. A sample response can be seen below (only one hourly and daily value are shown).

``` HTTP
status: 200
body:


{
    "data": {
        "id": "denver, co",
        "type": "forecast",
        "attributes": {
            "id": "denver, co",
            "name": "denver, co",
            "current_weather": {
                "data": {
                    "id": "1563322928",
                    "type": "current_weather",
                    "attributes": {
                        "id": 1563322928,
                        "current_temperature": 90.45,
                        "perceived_temperature": 90.45,
                        "max_temperature": 93.79,
                        "min_temperature": 69.92,
                        "current_weather": "Partly Cloudy",
                        "humidity": 0.22,
                        "visibility": 3.579,
                        "uv_index": 1,
                        "current_description": "Partly Cloudy",
                        "future_description": "Partly Cloudy"
                    }
                }
            },
            "hourly_forecasts": {
                "data": [
                    {
                        "id": "1563321600",
                        "type": "hourly_weather",
                        "attributes": {
                            "id": 1563321600,
                            "hour": 0,
                            "temperature": 90.81,
                            "weather": "Partly Cloudy"
                        }
                    },
                    {...}
                ]
            },
            "daily_forecasts": {
                "data": [
                    {
                        "id": "1563256800",
                        "type": "daily_weather",
                        "attributes": {
                            "id": 1563256800,
                            "day": "Tuesday",
                            "weather": "Partly cloudy throughout the day.",
                            "percipitation_chance": 0.16,
                            "max_temperature": 93.79,
                            "min_temperature": 69.92
                        }
                    },
                    {...}
                ]
            }
        }
    }
}
```

###### Requesting an image

The application provides the capability to serve a Flickr image for a city skyling based on the Geolocation provided with the request by submitting a `GET` request to the `/api/v1/backgrounds` endpoint. This request must include a location name with the parameter of `location`.

``` HTTP
status: 200
body:

{
    "data": {
        "id": "seattle, wa",
        "type": "background",
        "attributes": {
            "id": "seattle, wa",
            "url": "https://farm66.staticflickr.com/65535/48269324337_392d306ce2.jpg"
        }
    }
}
```

###### Creating favorites

The application supports the creation of favorite locations for authenticated users via a `POST` request to the `/api/v1/favorites` endpoint. This request must include an API key and a location in the body.

``` HTTP
POST /api/v1/favorites
Content-Type: application/json
Accept: application/json

{
  "api_key": "1a46d0f47e622496255c3ed9b08fef67",
  "location": "Austin, TX"
}
```

###### Retrieving favorites

The application supports returning a list of favorite cities registered for a user by submitting a `GET` request to the endpoint `/api/v1/favorites`. This request must include a parameter `api_key` with the key of the user.

If successful, the application will return a 200 status along with the list of all the users favorited locations, and the current weather at each location.

``` HTTP
status: 200
body:

[
    {
        "location": "austin, tx",
        "current_weather": {
            "data": {
                "id": "1563323233",
                "type": "current_weather",
                "attributes": {
                    "id": 1563323233,
                    "current_temperature": 93.2,
                    "perceived_temperature": 99.57,
                    "max_temperature": 97.03,
                    "min_temperature": 78.37,
                    "current_weather": "Partly Cloudy",
                    "humidity": 0.47,
                    "visibility": 8.319,
                    "uv_index": 0,
                    "current_description": "Partly Cloudy",
                    "future_description": "Humid and Mostly Cloudy"
                }
            }
        }
    }
]
```

In the event an invalid API key is provided or an API key is not provided, the application will return a 401 status.


###### Deleting favorites

The application also supports removal of favorite locations via a `DELETE` request to the endpoint `/api/v1/favorites`. The request must include the location to be deleted and an API key.

``` HTTP
DELETE /api/v1/favorites
Content-Type: application/json
Accept: application/json

{
  "api_key": "1a46d0f47e622496255c3ed9b08fef67",
  "location": "Austin, TX, USA"
}
```

The application will respond with a status of 200 when deleting the favorite, along with the favorite object.

``` HTTP
status: 204
body:

{
    "location": "austin, tx",
    "current_weather": {
        "data": {
            "id": "1563323495",
            "type": "current_weather",
            "attributes": {
                "id": 1563323495,
                "current_temperature": 93.2,
                "perceived_temperature": 99.57,
                "max_temperature": 97.03,
                "min_temperature": 78.37,
                "current_weather": "Partly Cloudy",
                "humidity": 0.47,
                "visibility": 8.319,
                "uv_index": 0,
                "current_description": "Partly Cloudy",
                "future_description": "Humid and Mostly Cloudy"
            }
        }
    }
}
```

In the event a location or API key is not provided, the application returns a 401 status.

### Known Issues

- Error handling for bad requests needs to be improved, both for sending messages if the user is unauthorized and for handling errors to prevent 500 returns.

- The application will re-geocode a location if the formatting of a forecast does not match the exact formatting of a resolved address

### Testing

Testing has been implemented using RSpec. To execute the test suite run `bundle exec rspec`.

### Contributing

To contribute to this project, please fork and issue a pull request to the master branch with a note indicating changes made.

### Core Contributors

@plapicola - Author

### Tech Stack

This application was built using the following technologies:

- Ruby
- Rails
- PostgreSQL
- Heroku
- Redis
