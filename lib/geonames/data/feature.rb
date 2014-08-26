require "pathname"

module Geonames
  module Data
    class Feature
      def self.field(name)
        @fields ||= []
        index = @fields.size
        @fields << name
        if block_given?
          define_method name do
            yield(@data[index])
          end
        else
          define_method name do
            @data[index]
          end
        end
      end

      field(:geoname_id, &:to_i)
      field(:name)
      field(:ascii_name)
      field(:alternate_names)   { |names| names.split(",") }
      field(:latitude,  &:to_f)
      field(:longitude, &:to_f)
      field(:feature_class)
      field(:feature_code)
      field(:country_code)
      field(:cc2)               { |cc2| cc2.split(",") }
      field(:admin1_code)
      field(:admin2_code)
      field(:admin3_code)
      field(:admin4_code)
      field(:population, &:to_i)
      field(:elevation,  &:to_i)
      field(:dem)
      field(:timezone)
      field(:modification_date)

      def initialize(data)
        @data = data.dup
      end

      def names
        @names ||= [ name, ascii_name, *alternate_names ]
      end

      def self.load(filepath, &filter)
        Pathname.new(filepath).open("r").inject([]) do |features, line|
          feature = Feature.new(line.strip.split("\t"))
          features.push(feature) if !block_given? || yield(feature)
          features
        end
      end
    end
  end
end
