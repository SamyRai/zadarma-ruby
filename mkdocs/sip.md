# SIP Resource

The SIP resource allows you to manage your SIP numbers.

## `all()`

Get the list of user's SIP-numbers.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.sips
```

## `set_caller_id(id:, number:)`

Set the CallerID for a SIP number.

**Parameters:**

*   `id` (String): The SIP ID.
*   `number` (String): The new CallerID.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.set_sip_caller_id(id: '123', number: '1234567890')
```

## `redirection(id: nil)`

Get call forwarding information for a SIP number.

**Parameters:**

*   `id` (String): The SIP ID.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.redirection(id: '123')
```

## `set_redirection(id:, status:, type: nil, number: nil, condition: nil)`

Set call forwarding for a SIP number.

**Parameters:**

*   `id` (String): The SIP ID.
*   `status` (String): The call forwarding status ('on' or 'off').
*   `type` (String): The call forwarding type ('phone', 'voicemail', etc.).
*   `number` (String): The destination number for call forwarding.
*   `condition` (String): The call forwarding condition ('always', 'noanswer', etc.).

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.set_redirection(id: '123', status: 'on', type: 'phone', number: '1234567890')
```

## `status(sip:)`

Get the online status of a SIP number.

**Parameters:**

*   `sip` (String): The SIP number.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.sip_status(sip: '123')
```

## `create(name:, password: nil, callerid: nil, redirect_to_phone: nil)`

Create a new SIP number.

**Parameters:**

*   `name` (String): The displayed name for the new SIP number.
*   `password` (String): The password for the new SIP number.
*   `callerid` (String): The CallerID for the new SIP number.
*   `redirect_to_phone` (String): The phone number to redirect calls to.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.create_sip(name: 'My SIP')
```

## `password(sip:, value:)`

Change the password for a SIP number.

**Parameters:**

*   `sip` (String): The SIP number.
*   `value` (String): The new password.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.set_sip_password(sip: '123', value: 'new_password')
```
