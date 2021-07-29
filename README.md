# SmallCinema app

The app implements the following parts of the recruitment task:

- documented REST API in OpenAPI format
- simple token-based authentication 
- movies endpoints
- movies/{movie_id}/showtimes set of endpoints
- integration with Omdb API

## Tech stack

- ruby 2.7.2
- postgres 12.3
- redis 6.0

Application is based on RubyOnRails --api-only framework. 
Development setup assumes you have a ruby environment in place and docker to run external services (postgres/redis).
Since I'm using Mac in most cases hybrid run mode is most efficient and performant from the developer's perspective.
Docker could be considered for continuous delivery, but since time is the matter I would rather recommend SaaS like Heroku.


## Setup instructions

```
bundle install
docker-compose up
rake db:create db:migrate db:seed
rails s
```
API docs can be found on `localhost:3000/api-docs`


## Approach

Because of the time limitation cutting the scope, focus on the two most important features and authentication.
Use rswag gem in test suite - a benefit that tests can produce a nice piece of documentation.
Protect API with a simple token-based authentication solution that can be extended in the future or replaced with some more bulletproof/secure one.

I tried to use the most Rails offers with a little touch of the SOLID principle. My proposal is to wrap business logic into UseCase which should complete the task or raise an error. I discourage Rails approach and put logic into controllers or models. I try to keep the balance between project size and code architecture. It seems small and most likely will stay small. Uses commonly known and broadly used libraries which shouldn't be a problem to find a dev team to support it in the feature.

Omdb API has been wrapped using Faraday and the response is cached in redis to avoid query limitation problems.

## Recommendations

- configure CI, tools for static code analysis(bundler-audit, standard), test runner, swagger docs generator  
- configure CD to some test environment using Heroku like solution
- configure monitoring tools and error trackings tools like DataDog and Sentry.io
- fix the problem with compromised master.key
- rethink authentication in terms of security, future use cases, like social logins -  maybe OAuth2 implicit grant flow
- implement authorization with Pundit gem
- in the future, you can take advantage of other libraries that dry-rb offers
