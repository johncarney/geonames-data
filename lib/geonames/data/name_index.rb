module Geonames
  module Data
    class NameIndex
      def initialize(features)
        @index = features.inject({}) do |index, feature|
          feature.names.inject(index) do |index, name|
            index[name] ||= []
            index[name].push(feature).uniq!
            index
          end
        end
      end

      def [](name)
        @index[name]
      end

      def self.load(filepath, &filter)
        new(Feature.load(filepath, &filter))
      end
    end
  end
end
