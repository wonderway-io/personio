# Personio

Ruby wrapper for the [personio](https://www.personio.de/) API.

Check out the yard documentation here: [doc](https://wonderwerk.github.io/personio/)

## Installation

Add this line to your application's Gemfile:

```ruby
    gem 'personio', github: 'wonderwerk/personio'
```

And then execute:

    $ bundle

This will load the personio gem from the github repository and make it available in your code.

## Usage

Require the personio gem in your code.

```ruby
require 'personio'
```

### Configuration

A client id and a client secret have to be provided for the gem to be able to
query the personio API. By default those values are retrieved from the
environment, checking for `PERSONIO_CLIENT_ID` and `PERSONIO_CLIENT_SECRET` to
be set. You can set those variables in your console by running:

```bash
  $ export PERSONIO_CLIENT_ID=client_id
  $ export PERSONIO_CLIENT_SECRET=client_secret.
```

The client id and secret are provided by personio. Log into your account
and download the strings under api keys in the settings.

Alternatively you can configure the gem in it's configuration block.

```ruby
  require 'personio'

  Personio.configure do |config|
    config.client_id = client_id
    config.client_secret = client_secret
  end
```

### Retrieving Employees

In order to query all employees from the configured personio account, given by
the used client id and secret, use the Employee Api underneath
`Personio.employees`:

```ruby
  Personio.employees.all
```

This function queries all Employees and returns an array of employee objects.

### Initializable API

Sometimes you might want to hold several instances of the personio api, in order
to query for multiple organisations simultaneously.
To achieve this, require `personio/api` instead of `personio`.
This makes a class `PersonioApi` available, which takes the same
arguments as `Personio` to initialize and exposes the same endpoints.

For instance, to query all employees:

```ruby
  require 'personio/api'

  # initialize the first api
  api = PersonioApi.new(
    client_id: '<my_id>',
    client_secret: '<my_secret>'
  )

  # get all employees
  employees = api.employees.all
```

### Testing

This gem comes with the option to mock the api requests.
When configuring personio, simply provide response data for the specific
endpoints needed and all requests will be mocked with the provided data.#

```ruby
  # Configure personio
  Personio.configure do |config|
    config.mocks = {
      employees: [
        {
          "first_name": "Robert",
          "last_name": "Jacobs",
          "email": "robert.jacobs@wonderwerk-sample.com",
          "gender": "male",
          "status": "active",
          "position": "Junior HR consultant",
          "employment_type": "internal",
          "supervisor": {
            "first_name": "Sarah",
            "last_name": "Becker",
            "email": "sarah.becker@wonderwerk-sample.com"
          }
        }
      ]
    }
  end
```

Now calling `Personio.employees.all` will return one employee: Robert Jacobs.

## Contribute

Please contact the repository host if you wish to contribute to this gem.

### Generating docs

Before pushing to the docs please make sure that the docs are up to date by
running:

```bash
  $ yard doc -o docs
```

The docs have to be committed along with the code changes.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
