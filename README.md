# Fullscript API prototype

Fullscript API prototype is a ruby on rails api created to rate products and keep learn more about Fullscript company

## Basic Flow
  1. A user login with their credentialss (provided as placeholders in form)
  2. Press the rate button
  3. A user can rate the available products

## Setup

1. Clone this repo
2. Create your `database.yml` and `application.yml` file. Don't forget to set your adapter as `postgis` instead of `postgres`
3. `bundle install`
4. Generate a secret key with `rake secret` and paste this value into the `application.yml`
5. `rake db:create`
6. `rake db:migrate`
7. `rails s`

## Demo

Want to give it a try? Here's a [demo](https://fullscript-web-prototype.herokuapp.com/login) for you to play with.

Check out the `seeds` for credentials.

## Code quality

With `rake code_analysis` you can run the code analysis tool, you can omit rules with:

- [Rubocop](https://github.com/bbatsov/rubocop/blob/master/config/default.yml) Edit `.rubocop.yml`
- [Reek](https://github.com/troessner/reek#configuration-file) Edit `config.reek`
- [Rails Best Practices](https://github.com/flyerhzm/rails_best_practices#custom-configuration) Edit `config/rails_best_practices.yml`
- [Brakeman](https://github.com/presidentbeef/brakeman) Run `brakeman -I` to generate `config/brakeman.ignore`
- [Bullet](https://github.com/flyerhzm/bullet#whitelist) You can add exceptions to a bullet initializer or in the controller
