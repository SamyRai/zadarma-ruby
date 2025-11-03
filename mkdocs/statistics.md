# Statistics Resource

The Statistics resource provides access to call statistics.

## `statistics(params)`

Get overall call statistics.

**Parameters:**

*   `params` (Hash): The parameters for the statistics request.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.statistics(start: '2023-01-01', end: '2023-01-31')
```

## `pbx_statistics(params)`

Get PBX call statistics.

**Parameters:**

*   `params` (Hash): The parameters for the PBX statistics request.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.pbx_statistics(start: '2023-01-01', end: '2023-01-31')
```
