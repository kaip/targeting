How to run
==========
* Install ruby
* Run ruby runner.rb with two JSON string arguments: data (a standard hash) and expression (see below for format)

For example: `ruby runner.rb "{\"country\":\"usa\",\"os_version\":\"6.1.1\",\"language\":\"english\",\"app_version\":\"0.2\"}" "{\"and\":[{\"or\":[{\"country\":\"usa\"},{\"language\":\"spanish\"}]},{\"not\":{\"or\":[{\"app_version\":\"0.2\"},{\"os_version\":\"7.0.0\"}]}}]}"`

Expression Format
=================
Expressions are JSON hashes of arrays of hashes

And/or expressions should have 'and'/'or' as the key and an array of two hashes as the value `{'and' => [{'country' => 'usa'}, {'os_version' => '6.1.1'}]}`

Not expressions should have 'not' as the key and the negated expression hash as the value `{'not' => {'country' => 'usa'}}`

Leaf/equality expressions should have the key as the key and the value as the value `{'country' => 'usa'}`

So the expression `(((country == 'usa') or (language == 'spanish')) and (not ((app_version == '0.2') or (os_version == '7.0.0'))))` would be expressed as:
`"{\"and\":[{\"or\":[{\"country\":\"usa\"},{\"language\":\"spanish\"}]},{\"not\":{\"or\":[{\"app_version\":\"0.2\"},{\"os_version\":\"7.0.0\"}]}}]}"`

Notes
=====
This engine supports arbitrary properties (just include them in the data and expression hash)

It supports string, int, float, or boolean properties

It assumes properties not given in the data are nil, which is not the same as ''