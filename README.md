# Zadarma API Ruby Client

A modern, robust, and fully-featured Ruby client for the Zadarma API. This gem has been updated to support the latest Zadarma API, providing a clean and intuitive interface for all available endpoints.

## Getting Started

### Prerequisites

- Ruby 2.7 or later
- A Zadarma account
- Your Zadarma API key and secret

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'zadarma'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zadarma

## Configuration

First, configure the client with your API key and secret. You can find these in your Zadarma personal account.

```ruby
require 'zadarma'

client = Zadarma::Client.new(api_key: 'YOUR_API_KEY', api_secret: 'YOUR_API_SECRET')
```

## Usage

Now you can call any of the available API methods:

### Get Your Balance

```ruby
response = client.balance
puts "Your balance is #{response['balance']} #{response['currency']}."
```

### Get Call Price

```ruby
response = client.price(number: '1234567890')
puts "The price to call 1234567890 is #{response['info']['price']} per minute."
```

### Request a Callback

```ruby
response = client.callback(from: 'YOUR_NUMBER', to: 'DESTINATION_NUMBER')
puts "Callback initiated from #{response['from']} to #{response['to']}."
```

### Send an SMS

```ruby
response = client.send_sms(number: 'DESTINATION_NUMBER', message: 'Hello from Zadarma!')
puts "SMS sent. Cost: #{response['cost']} #{response['currency']}."
```

### Get Call Statistics

```ruby
response = client.statistics(start: '2023-01-01', end_date: '2023-01-31')
response['stats'].each do |call|
  puts "Call from #{call['from']} to #{call['to']} on #{call['callstart']}."
end
```

## Available Methods

This client is organized into resources, mirroring the Zadarma API structure.

*   **Info**
    *   `balance`: Get your current account balance.
    *   `price(number:, caller_id: nil)`: Get the price for a call to a specific number.
*   **PBX**
    *   `internal_numbers`: Get a list of your internal PBX numbers.
    *   `set_call_recording(id:, status:, email: nil, speech_recognition: nil)`: Enable or disable call recording for a PBX extension.
*   **Direct Numbers (Virtual Numbers)**
    *   `direct_numbers`: Get a list of your virtual numbers.
*   **Request**
    *   `callback(from:, to:, sip: nil, predicted: nil)`: Initiate a callback between two numbers.
*   **SIP**
    *   `sips`: Get a list of your SIP numbers.
    *   `set_sip_caller_id(id:, number:)`: Set the CallerID for a SIP number.
    *   `redirection(id: nil)`: Get call forwarding information for a SIP number.
    *   `set_redirection(id:, status:, type: nil, number: nil, condition: nil)`: Set call forwarding for a SIP number.
*   **SMS**
    *   `send_sms(number:, message:, sender: nil)`: Send an SMS message.
*   **Statistics**
    *   `statistics(start:, end_date:, sip: nil, cost_only: nil, type: nil, skip: nil, limit: nil)`: Get overall call statistics.
    *   `pbx_statistics(start:, end_date:, version: nil, skip: nil, limit: nil, call_type: nil)`: Get PBX call statistics.

## Development

To work on this gem locally, clone the repository and then run `bundle install` to install the dependencies.

This gem uses RSpec for testing. To run the test suite, simply run:

    $ bundle exec rspec

The test suite is configured to use `webmock` to stub out all API requests, so you can run the tests without needing a live Zadarma account or making real API calls.

## Contributing

1.  Fork it ( https://github.com/SamyRai/zadarma-ruby/fork )
2.  Create your feature branch (`git checkout -b my-new-feature`)
3.  Commit your changes (`git commit -am 'Add some feature'`)
4.  Push to the branch (`git push origin my-new-feature`)
5.  Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](https'://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Zadarma project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).

## Version History

*   **2.0.0** - The current version.
