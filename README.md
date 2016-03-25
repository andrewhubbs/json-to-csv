# json_converter
A small ruby class to convert JSON into a tabular, comma-separated format.

## Installation
`gem install json_converter`

## Usage
The JsonConverter is able to convert objects created with `JSON.parse`, as well as (valid) raw JSON strings.

    require 'json_converter'
    converter = JsonConverter.new
    
    json = some_valid_json_object_or_string
    
    csv = converter.generate_csv json               # Generate a CSV string...
    converter.write_to_csv json, 'boiled_frogs.csv' # ... or write your CSV to a file



Inspired by http://konklone.io/json/.

## TODO
* Add arguments to documentation
