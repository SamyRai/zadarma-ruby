# Request Resource

The Request resource allows you to initiate callbacks.

## `callback(from:, to:, sip: nil, predicted: nil)`

Request a callback.

**Parameters:**

*   `from` (String): Your phone/SIP number, the PBX extension or the PBX scenario.
*   `to` (String): The phone or SIP number that is being called.
*   `sip` (String): The SIP user's number or the PBX extension.
*   `predicted` (String): If specified, the request is predicted.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.callback(from: '1234567890', to: '0987654321')
```
