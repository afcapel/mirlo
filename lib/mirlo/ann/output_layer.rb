class Mirlo::OutputLayer < Mirlo::NeuronLayer
  attr_accessor :errors, :previous_layer

  def expected_targets=(target_matrix)
    @expected_targets = target_matrix
  end

  def outputs
    @activations.row_vectors.collect(&:to_a)
  end

  def calculate_errors
    num_samples = @expected_targets.row_count

    @errors = (@expected_targets - @activations).collect { |elm| elm/num_samples }
  end
end