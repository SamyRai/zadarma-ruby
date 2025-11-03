# SMS Resource

The SMS resource allows you to send SMS messages.

## `send_sms(number:, message:, sender: nil)`

Send an SMS message.

**Parameters:**

*   `number` (String): The destination phone number.
*   `message` (String): The SMS message text.
*   `sender` (String): The SMS sender (virtual number or text).

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.send_sms(number: '1234567890', message: 'Hello, world!')
```
