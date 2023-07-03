# PathSync API

## Codebase Setup

* Clone the project using Code dropdown
* Run `bundle install` to get all gems working
* Create or modify `database.yml` to suit your database environment
* If `master.key` required to proceed further for setup, contact project administrator to get it
* Setup db by running commands `rails db:create && rails db:migrate`
* Run test suite by `rspec spec -f d` command. Make sure all tests are green
* Start the server using `rails s`
* To run sidekiq, use `bundle exec sidekiq` in a separate terminal window/tab

## Endpoints Consumption

* APIs are accessible under the route POST /graphql
* Use Postman to fire up Queries and Mutations
* Team shared Postman space have the neccessary documentation

## GraphQL API Mocker

There's a separate branch __mocking-graphql-ai__ which has `gem mock-graphql-ai` implementation. You can switch if you want to consume OpenAI gpt-3.5 turbo to generate mock responses for you.

## PRs Follow-ups

* Its mandatory to add test cases for newly added features and changes in PRs
* GitHub Actions are enabled for Test Suite automation, PRs will not get merged until the associated hook turns green