# json-to-csv
A small ruby class to convert JSON into a tabular, comma-separated format.

# Usage
    # Target JSON can either be a valid JSON string or a JSON object parsed with JSON.parse
    json = valid_json_string_or_object
    
    # Generate a CSV string...
    csv = JsonConverter.generate_csv json
    
    # ...Or write the generated CSV to a file
    csv = JsonConverter.write_csv json, 'boiled_frogs.csv'

Inspired by http://konklone.io/json/.

## TODO
* More readme stuff
* Maybe add a license, all of the cool kids are doing it
