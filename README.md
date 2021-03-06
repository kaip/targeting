How to run
==========
* Install ruby
* git clone this repository
* cd into the directory
* Run `bundle`
* Run `ruby runner.rb` with two JSON string arguments: data (a standard hash) and expression (see below for format)

For example: `ruby runner.rb "{\"country\":\"usa\",\"os_version\":\"6.1.1\",\"language\":\"english\",\"app_version\":\"0.2\"}" "{\"and\":[{\"or\":[{\"=\":{\"country\":\"usa\"}},{\"=\":{\"language\":\"spanish\"}}]},{\"not\":[{\"or\":[{\"=\":{\"app_version\":\"0.2\"}},{\"=\":{\"os_version\":\"7.0.0\"}}]}]}]}"`

Expression Format
=================
Expressions are JSON hashes

Leaf expressions should have the operator as the key and a hash with the key to check as the key and the value to compare as the value `{'>' => {'num_purchases' => 5}`

Non-leaf expressions should have the operator as the key and an array of hashes as the value `{'and' => [{'=' => {'country' => 'usa'}, {'=' => {'os_version' => '6.1.1'}]}`

So the expression `(((country == 'usa') or (language == 'spanish')) and (not ((app_version == '0.2') or (os_version == '7.0.0'))))` would be expressed as:
`"{\"and\":[{\"or\":[{\"=\":{\"country\":\"usa\"}},{\"=\":{\"language\":\"spanish\"}}]},{\"not\":[{\"or\":[{\"=\":{\"app_version\":\"0.2\"}},{\"=\":{\"os_version\":\"7.0.0\"}}]}]}]}"`

Notes
=====
This engine supports arbitrary properties (just include them in the data and expression hash)

It supports string, int, float, or boolean properties

It assumes properties not given in the data are nil, which is not the same as ''

It supports the operators: and, or, not, =, >, <

And/or can have arbitrary number of subexpressions: `{'or' => [{'=' => {'country' => 'usa'}}, {'=' => {'country' => 'canada'}}, {'=' => {'country' => 'england'}}]}` is equivalent to `country == 'usa' or country == 'canada' or country == 'england'`
