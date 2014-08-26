require "geonames/data/version"
require "geonames/data/feature"
require "geonames/data/name_index"
require "geonames/data/location_index"

module Geonames
  module Data
    def self.load_features(filepath, &filter)
      Feature.load(filepath, &filter)
    end
  end
end
