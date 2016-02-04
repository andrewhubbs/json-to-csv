require 'csv'
require 'json'

unless ARGV.length === 2
  puts 'usage: ruby json_to_csv.rb [input.json] [output.csv]' 
  exit
end

# Recursively convert all nil values of a hash to empty strings
def nils_to_strings(hash)
  hash.each_with_object({}) do |(k,v), object|
    case v
    when Hash
      object[k] = nils_to_strings v
    when nil
      object[k] = ''
    else
      object[k] = v
    end
  end
end

# The path argument is used to construct header columns for nested elements
def flatten(object, path='')
  scalars = [String, Integer, Fixnum, FalseClass, TrueClass]
  columns = {}

  if [Hash, Array].include? object.class
    object.each do |k, v|
      new_columns = flatten(v, "#{path}#{k}/") if object.class == Hash
      new_columns = flatten(k, "#{path}#{k}/") if object.class == Array
      columns = columns.merge new_columns
    end

    return columns
  elsif scalars.include? object.class
      # Remove trailing slash from path
      end_path = path[0, path.length - 1]
      columns[end_path] = object
      return columns
  else
    return {}
  end
end

def array_from(json)
  queue, next_item = [], json
  while !next_item.nil?

    return next_item if next_item.is_a? Array

    if next_item.is_a? Hash
      next_item.each do |k, v|
        queue.push next_item[k]
      end
    end

    next_item = queue.shift
  end

  return [json]
end

json = JSON.parse(File.open(ARGV[0]).read)
in_array = array_from json

# Having nils in the data will generally result in uneven rows; The easiest
# way to solve this is to replace them with empty strings.
in_array.map! { |x| nils_to_strings x }

out_array = []
in_array.each do |row|
  out_array[out_array.length] = flatten row
end

headers_written = false
CSV.open(ARGV[1].to_s, 'w') do |csv|
  out_array.each do |row|
    csv << row.keys && headers_written = true if headers_written === false
    csv << row.values
  end
end

