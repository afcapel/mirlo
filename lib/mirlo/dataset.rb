require_relative 'feature_vectorization'

module Mirlo

  # Public: Dataset class to store a set of samples with their associated targets.
  #
  class Dataset
    include Enumerable
    include Plotting
    include FeatureVectorization

    DEFAULT_LABELS = {
      [0]  => 'Zero',
      [1]  => 'Positive',
      [-1] => 'Negative'
    }

    attr_reader :title, :samples, :feature_names

    def initialize(samples: [], targets: nil, feature_names: [], title: "Dataset", add_bias: true, labels: DEFAULT_LABELS)
      @feature_names ||= feature_names
      @title         ||= title
      @labels        ||= labels

      @samples = if targets.nil?
        samples
      else
        build_from_samples_and_targets(samples, targets)
      end
    end

    def feature(feature_name_or_index)
      index = if feature_names.include?(feature_name_or_index)
        feature_names.index(feature_name_or_index)
      else
        feature_name_or_index
      end

      samples.collect { |sample| sample[index] }
    end

    def subset_with_target(target)
      matching_samples = samples.find_all { |s| s.target == target }
      Dataset.new(samples: matching_samples, feature_names: feature_names, title: target)
    end

    def targets_for(feature_values)
      samples.select { |s| s.has_features?(feature_values) }.collect(&:target)
    end

    def label_for(val)
      @labels[val] || val
    end

    def target_set
      targets.uniq.sort
    end

    def targets
      samples.collect(&:target)
    end

    def size
      @samples.size
    end

    def each(*args, &block)
      @samples.each(*args, &block)
    end

    def num_features
      @num_features ||= samples.first.feature_size
    end

    def num_outputs
      @num_outputs ||= samples.first.target_size
    end

    def input_matrix
      @input_matrix ||= Matrix.rows(samples.collect(&:features), false)
    end

    def target_matrix
      @target_matrix ||= Matrix.rows(samples.collect(&:target), false)
    end

    def shuffle!
      @input_matrix = @target_matrix = nil

      shuffled_positions = (0..size-1).to_a.shuffle

      shuffled_samples = shuffled_positions.collect { |i| samples[i] }
      shuffled_targets = shuffled_positions.collect { |i| targets[i] }

      @samples, @targets = shuffled_samples, shuffled_targets
    end

    private

    def build_from_samples_and_targets(samples, targets)
      samples.each_with_index.collect do |sample, index|
        sample = vectorize(sample)
        SampleWithBias.new(target: targets[index], features: sample)
      end
    end
  end
end