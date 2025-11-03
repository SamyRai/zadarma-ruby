# Info Resource

The Info resource provides access to user information, such as balance and call rates.

## `balance()`

Get the user's balance.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.balance
```

## `price(number:, caller_id: nil)`

Get the call rate for a given number.

**Parameters:**

*   `number` (String): The phone number.
*   `caller_id` (String): The CallerID to be used for the call.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.price(number: '1234567890')
```
