# Zadarma SDK Ruby Client

A modern, robust, and fully-featured Ruby client for the Zadarma API. This gem has been updated to support the latest Zadarma API, providing a clean and intuitive interface for all available endpoints.

## Getting Started

### Prerequisites

- Ruby 2.7 or later
- A Zadarma account
- Your Zadarma API key and secret

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'zadarma_sdk'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zadarma_sdk

## Configuration

First, configure the client with your API key and secret. You can find these in your Zadarma personal account.

```ruby
require 'zadarma_sdk'

client = ZadarmaSdk::Client.new(api_key: 'YOUR_API_KEY', api_secret: 'YOUR_API_SECRET')
```

## Usage

Now you can call any of the available API methods.

## API Resources

This client is organized into resources, mirroring the Zadarma API structure. For a detailed list of methods and parameters, please see the [developer documentation](mkdocs/index.md).

## Development

To work on this gem locally, clone the repository and then run `bundle install` to install the dependencies.

This gem uses RSpec for testing. To run the test suite, simply run:

    $ bundle exec rspec

The test suite is configured to use `webmock` to stub out all API requests, so you can run the tests without needing a live Zadarma account or making real API calls.

## Contributing

1.  Fork it
2.  Create your feature branch (`git checkout -b my-new-feature`)
3.  Commit your changes (`git commit -am 'Add some feature'`)
4.  Push to the branch (`git push origin my-new-feature`)
5.  Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ZadarmaSdk project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).
