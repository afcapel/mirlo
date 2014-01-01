module Mirlo
  class Perceptron < Classifier
    attr_accessor :learning_rate

    def initialize(learning_rate = DEFAULT_LEARNING_RATE)
      @learning_rate = learning_rate
    end

    def activations(inputs = train_set.input_matrix)
      (inputs * weights).collect { |v| v > 0 ? 1 : 0 }
    end

    def classify(input)
      input = SampleWithBias.new(features: input) unless input.is_a?(Mirlo::Sample)

      input_vector = Matrix[input.features]
      result = (input_vector * weights).row(0).to_a
      result.collect { |v| v > 0 ? 1 : 0 }
    end

    def weight_updates
      train_set.input_matrix.transpose * (train_set.target_matrix - activations)
    end

    def iterate
      @weights = weights + learning_rate * weight_updates
    end

    def weights
      @weights ||= Matrix.build(train_set.num_features, train_set.num_outputs) { rand(-0.05..0.05) }
    end
  end
end