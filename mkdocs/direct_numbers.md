# Direct Numbers Resource

The Direct Numbers resource allows you to manage virtual numbers.

## `all()`

Get information about the user's virtual numbers.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.direct_numbers
```

## `countries(language: nil)`

Get a list of countries where numbers can be ordered.

**Parameters:**

*   `language` (String): The language for the country names.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.direct_number_countries(language: 'en')
```

## `country(country:, language: nil, direction_id: nil)`

Get a list of destinations in a country where a number can be ordered.

**Parameters:**

*   `country` (String): The ISO country code.
*   `language` (String): The language for the destination names.
*   `direction_id` (String): The direction ID.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.direct_number_country(country: 'US')
```

## `available(direction_id:, mask: nil)`

Get a list of available numbers for a given direction.

**Parameters:**

*   `direction_id` (String): The direction ID.
*   `mask` (String): A mask for searching number matches.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.available_direct_numbers(direction_id: '123')
```

## `order(params)`

Order a virtual number.

**Parameters:**

*   `params` (Hash): The parameters for ordering a number.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.order_direct_number(direction_id: '123', number_id: '456')
```

## `prolong(number:, months:)`

Prepay the number for the specified number of months.

**Parameters:**

*   `number` (String): The number to be prolonged.
*   `months` (Integer): The number of months.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.prolong_direct_number(number: '1234567890', months: 3)
```
