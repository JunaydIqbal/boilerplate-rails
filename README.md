# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Instructions to enable Rubocop as Linter

* Uncomment rubocop gems declaration from Gemfile

* Create a file named .rubocop.yml in project directory with this config:

require:
  - rubocop
  - rubocop-rails

AllCops:
  EnabledByDefault: true

Style/Copyright:
  Description: 'Include a copyright notice in each file before any code.'
  Enabled: false
  VersionAdded: '0.30'
  Notice: '^Copyright (\(c\) )?2[0-9]{3} .+'
  AutocorrectNotice: ''

* Enable rubocop extension in your code editor to pick real time code offenses