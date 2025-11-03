# Zadarma API Ruby Client Documentation

Welcome to the developer documentation for the Zadarma API Ruby Client. This guide provides detailed information about every aspect of the gem, from installation and configuration to a complete reference of all available API methods.

## Getting Started

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'zadarma'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zadarma

### Configuration

First, configure the client with your API key and secret. You can find these in your Zadarma personal account.

```ruby
require 'zadarma'

client = Zadarma::Client.new(api_key: 'YOUR_API_KEY', api_secret: 'YOUR_API_SECRET')
```

## API Resources

This client is organized into resources, mirroring the Zadarma API structure. Click on a resource below for a detailed list of its methods and parameters.

*   [Info](info.md)
*   [PBX](pbx.md)
*   [Direct Numbers](direct_numbers.md)
*   [Request](request.md)
*   [SIP](sip.md)
*   [SMS](sms.md)
*   [Statistics](statistics.md)
*   [Speech Recognition](speech_recognition.md)
*   [Groups of Documents](groups_of_documents.md)
