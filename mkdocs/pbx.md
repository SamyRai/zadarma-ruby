# PBX Resource

The PBX resource allows you to manage your Zadarma PBX.

## `internal()`

Get the list of PBX internal numbers.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.internal_numbers
```

## `set_call_recording(id:, status:, email: nil, speech_recognition: nil)`

Set the call recording for a PBX extension.

**Parameters:**

*   `id` (String): The PBX extension ID.
*   `status` (String): The call recording status ('on', 'off', etc.).
*   `email` (String): The email address to send recordings to.
*   `speech_recognition` (String): The speech recognition settings.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.set_call_recording(id: '123', status: 'on')
```

## `pbx_record_request(call_id: nil, pbx_call_id: nil, lifetime: nil)`

Request a call recording file.

**Parameters:**

*   `call_id` (String): The unique call ID.
*   `pbx_call_id` (String): The permanent ID of the external call to the PBX.
*   `lifetime` (Integer): The link's lifetime in seconds.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.pbx_record_request(call_id: '12345')
```
