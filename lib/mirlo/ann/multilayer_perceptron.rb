module Mirlo
  class MultilayerPerceptron < Classifier

    attr_accessor :learning_rate, :momentum, :input_layer, :hidden_layers, :output_layer

    def initialize(learning_rate: DEFAULT_LEARNING_RATE, momentum: 0.9)
      @learning_rate, @momentum = learning_rate, momentum
      @hidden_layers = []
    end

    def iterate
      # train_set.shuffle!

      input_layer.inputs = train_set.input_matrix
      output_layer.expected_targets = train_set.target_matrix

      move_forward
      move_backward
    end

    def move_forward(inputs = nil)
      hidden_layers.each(&:calculate_activations)
      output_layer.calculate_activations
    end

    def move_backward
      output_layer.calculate_errors
      hidden_layers.reverse.each { |layer| layer.calculate_errors }

      output_layer.update_weights(learning_rate, momentum)
      hidden_layers.reverse.each { |layer| layer.update_weights(learning_rate, momentum) }
    end

    def classify(input)
      input_layer.input = input
      move_forward
      output_layer.outputs.first.collect(&:round)
    end

    def layers
      [input_layer, hidden_layers, output_layer].flatten.compact
    end
  end
end