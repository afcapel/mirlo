module Mirlo

  # Public: This module transforms textual features in a dataset into numerical
  # indexes so they can be treated by machine learning algorithms. The main entry
  # point in the module is #vectorize(features) which replaces in an array of
  # features those that are not numeric by an integer.
  #
  # Examples
  #
  #   dataset = Dataset.new(feature_names: 'Weight', 'Color')
  #
  #   dataset.vectorize(0.1, 'Blue')
  #   # => [0.1, 0]
  #
  #   dataset.vectorize(0.3, 'Red')
  #   # => [0.3, 1]
  #
  #   dataset.vectorize(0.2, 'Red')
  #   # => [0.2, 1]
  #
  #   dataset.index_for('Color', 'Red')
  #   # => 1
  #
  #   dataset.index_for(1, 'Red')
  #   # => 1
  module FeatureVectorization

    # Public: Transforms any non numeric value to an integer based on its place of
    # appereance in the dataset.
    #
    def vectorize(features)
      features.each_with_index.collect do |feature, index|
        if feature.is_a?(Numeric)
          feature
        else
          feature_name = index_for(index, feature)
        end
      end
    end

    def index_for(feature_name_or_index, value)
      return nil unless indexes = indexes_for(feature_name_or_index)

      index = indexes[value]

      if index.nil?
        index = indexes.keys.size
        indexes[value] = index
      end

      index
    end

    def indexes_for(feature_name_or_index)
      return nil unless index = feature_index(feature_name_or_index)

      feature_indexes[index] ||= {}
    end

    def feature_index(feature_name_or_index)
      if feature_name_or_index.is_a?(Integer)
        feature_name_or_index
      else
        feature_names.index(feature_name_or_index)
      end
    end

    def feature_indexes
      @feature_indexes ||= {}
    end
  end
end