# SecretBroker

See the usage section for more details

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'secret_broker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install secret_broker

After installing the gem you can run the installation rake task which sets up
staging and production ejson files with public keys. Command:

    $ bundle exec rake secret_broker:install_secrets

## Working with Secrets/Usage

### Overview

We use EJSON to store secrets for remote environments in the git repo.
EJSON encrypts secrets so they
are not stored in plaintext. EJSON files are stored in
`config/secrets/environment.ejson`. EJSON is only used in remote environments.
Secrets from EJSON are decrypted when the app boots.

### Accessing Secrets in the Application

All application secrets should come from `Rails.application.secrets.secret_key`
which is loaded from `config/secrets/yml`. Since
`Rails.application.secrets.secret_key` is cumbersome to write, you can also
write `Secrets.secret_key`.

### Modifying Secrets

### Local Environment

Open up `config/secrets.yml` and change the secret you want to change.

#### Remote Environment

Open up the EJSON file for the environment you want to change the secret for.
Find the key for the secret you want to change. Replace the encrypted value
with the plaintext value. Run `ejson encrypt environment.ejson`. Then add and
commit the file.

Example scenario: I want to change the production database password.

Open `config/secrets/production.ejson`. It looks like:
```
{
  "_public_key": "some_value",
  "some_secret_key: "ENCRYPTED_VALUE",
  "database_password": "ENCRYPTED_OLD_PASSWORD",
  "some_other_secret_key: "ENCRYPTED_VALUE"
}
```

Modify the file with the new password. It looks like:
```
{
  "_public_key": "some_value",
  "some_secret_key: "ENCRYPTED_VALUE",
  "database_password": "new_plaintext_pa$$w0rd",
  "some_other_secret_key: "ENCRYPTED_VALUE"
}
```

Run `ejson encrypt production.ejson`. It looks like:
```
{
  "_public_key": "some_value",
  "some_secret_key: "ENCRYPTED_VALUE",
  "database_password": "ENCRYPTED_NEW_PASSWORD",
  "some_other_secret_key: "ENCRYPTED_VALUE"
}
```

Run `git add config/secrets/production.ejson && git commit -m "Updated
production database password`.

### References

[EJSON gem on Github](https://github.com/Shopify/ejson)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
