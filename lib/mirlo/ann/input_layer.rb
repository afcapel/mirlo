module Mirlo
  class InputLayer
    attr_accessor :next_layer, :inputs

    def initialize(input_size)
      @input_size = input_size
      @inputs = Matrix.zero(1, input_size)
    end

    def size
      @input_size + 1
    end

    def input=(input)
      sample = input.is_a?(Mirlo::Sample) ? input :  Mirlo::SampleWithBias.new(features: input)
      @inputs = Matrix.row_vector(sample.features)
    end

    def activation_matrix
      @inputs
    end
  end
end