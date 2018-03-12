# PersonioWonderwerk

Ruby wrapper for the [personio](https://www.personio.de/) API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'personio_wonderwerk'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install personio_wonderwerk

## Usage

Require the personio_wonderwerk gem in your code.

```ruby
require 'personio_wonderwerk'
```

### Configuration

A client id and a client secret have to be provided for the gem to be able to
query the personio API. By default those values are retrieved from the
environment, checking for `PERSONIO_CLIENT_ID` and `PERSONIO_CLIENT_SECRET` to
be set. You can set those variables in your console by running:

```bash
  export PERSONIO_CLIENT_ID=client_id
  export PERSONIO_CLIENT_SECRET=client_secret.
```

The client id and secret are provided by personio. Log into your account
and download the strings under api keys in the settings.

Alternatively you can configure the gem in it's configuration block.

```ruby
  require 'personio_wonderwerk'

  PersonioWonderwerk.configure do |config|
    config.client_id = client_id
    config.client_secret = client_secret
  end
```

### Retrieving Employees

In order to query all employees from the configured personio account, given by
the used client id and secret, use the Employee Api underneath
`PersonioWonderwerk.employees`:

```ruby
  PersonioWonderwerk.employees.all
```

This function queries all Employees and returns an array of employee objects.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
