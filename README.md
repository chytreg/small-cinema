# SmallCinema app

The app implements following parts of the recuritment task:

- documented REST API in OpenAPI format
- simple token based authentication 
- movies endpoints
- movies/{movie_id}/showtimes set of endpoints
- integration with Omdb API

## Tech stack

- ruby 2.7.2
- postgres 12.3
- redis 6.0

Application based on RubyOnRails --api-only framework. 
Development setup assumes you have a ruby environment in place and docker to run external services (postgres/redis).
Since I'm using Mac in most cases hybrid run mode is most efficent and perfromant from developer perspective.
Docker could be consider for continous delivery, but since time is the matter I would rather recommend SaaS like Heroku.


## Setup instructions

```
bundle install
docker-compose up
rake db:create db:migrate db:seed
rails s
```
API docs can be found on `localhost:3000/api-docs`


## Approach

Becasue of the time limitation cuting the scope, foucs on 2 most important features and authentication.
Use rswag gem in test suite - benefit that tests can produce nice pice of documentation.
Protect API with simple token based authentication solution which can be extended in the future or replaced to some more bullet proof / secure one.



## Recommendations

- configure CI, tools for static code analysys(bundler-audit, standard),test runner, swagger docs generator  
- configure CD to some test environment using Heroku like solution
- configure monitoring tool and error tracking tool like DataDog and Sentry.io
