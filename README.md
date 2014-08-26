# Geonames::Data

Library for working with [Geonames data][geonames-data].

## Installation

Add this line to your application's Gemfile:

    gem 'geonames-data'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install geonames-data

## Usage

To load a set of Geonames features:

```ruby
Geonames::Data.load_features("cities1000.txt")
```

Some of the Geonames files can be unworkably huge, so you can provide a filter
block to `load_features`. The following example will load only airports:

```ruby
Geonames::Data.load_features("allCountries.txt") do |feature|
  feature.feature_code == "AIRP"
end
```

### Indexing

Once you've got a set of features, you will probably want to index them
somehow. There are two classes provided for this: `Geonames::Data::NameIndex`
and `Geonames::Data::LocationIndex`.

#### Name index

`Geonames::Data::NameIndex` indexes Geonames features by name, including their
ASCII name and all alternate names.

```ruby
cities = Geonames::Data.load_features("cities1000.txt")
index = Geonames::Data::NameIndex.new(cities)
index["Melbourne"]
```

#### Location index

`Geonames::Data::LocationIndex` indexes Geonames features by geolocation
(latitude and longitude).

```ruby
Geonames::Data.load_features("allCountries.txt") do |feature|
  feature.feature_code == "AIRP"
end
index = Geonames::Data::NameIndex.new(cities)
index.nearest(-37.814, 144.96332)
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/geonames-data/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[geonames-data]: http://download.geonames.org/export/dump
