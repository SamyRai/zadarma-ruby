# Groups of Documents Resource

The Groups of Documents resource allows you to manage groups of documents.

## `files(group_id: nil)`

Get the list of files/documents in the group of documents.

**Parameters:**

*   `group_id` (String): The group of documents ID.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.document_files(group_id: '123')
```

## `list()`

Get the list of groups of documents.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.document_groups
```

## `get(id:)`

Get information on a certain group.

**Parameters:**

*   `id` (String): The group ID.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.get_document_group(id: '123')
```

## `create(params:)`

Create a new group of documents.

**Parameters:**

*   `params` (Hash): The parameters for creating a new group of documents.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.create_document_group(params: { name: 'My Group' })
```

## `update(id:, params:)`

Update a group of documents.

**Parameters:**

*   `id` (String): The group ID.
*   `params` (Hash): The parameters for updating a group of documents.

**Returns:**

A `Hash` containing the API response.

**Example:**

```ruby
client.update_document_group(id: '123', params: { name: 'My New Group' })
```
