# Speech Recognition Resource

The Speech Recognition resource allows you to manage speech recognition.

## `get(call_id:, lang: nil, return_results: nil, alternatives: nil)`

Get recognition results.

**Parameters:**

*   `call_id` (String): The unique call ID.
*   `lang` (String): The recognition language.
*   `return_results` (String): The returned result ('words' or 'phrases').
*   `alternatives` (String): Return alternative results ('0' or '1').

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.get_speech_recognition(call_id: '12345')
```

## `initiate(call_id:, lang: nil)`

Initiate call recognition.

**Parameters:**

*   `call_id` (String): The unique call ID.
*   `lang` (String): The recognition language.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.initiate_speech_recognition(call_id: '12345')
```
