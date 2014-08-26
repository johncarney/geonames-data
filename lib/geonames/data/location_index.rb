require "kdtree"

module Geonames
  module Data
    class LocationIndex
      def initialize(features)
        @features = features.inject({}) { |index, feature| index.update(feature.geoname_id => feature) }
        points = features.map do |feature|
          [ feature.latitude, feature.longitude, feature.geoname_id ]
        end
        @index = Kdtree.new(points)
      end

      def nearest(latitude, longitude)
        @features[@index.nearest(latitude, longitude)]
      end

      def self.load(filepath, &filter)
        new(Features.load(filepath, filter))
      end
    end
  end
end
