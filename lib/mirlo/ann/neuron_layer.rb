class Mirlo::NeuronLayer
  attr_accessor :previous_layer, :size, :activations, :errors, :build_weight_function

  def initialize(size)
    @size = size
    @errors = Array.new(size, 0)
  end

  def inputs_matrix
    # debugger
    previous_layer.activation_matrix * weights
  end

  def calculate_activations
    @activations = activation_matrix
  end

  def activation_matrix
    inputs_matrix.collect { |i| activation_function(i) }
  end

  def error_matrix
    Matrix.row_vector(@errors)
  end

  def activation_function(input)
    1.0/(1 + Math.exp(-input))
  end

  def weights
    @weights ||= Matrix.build(previous_layer.size, size) { build_weight }
  end

  def update_weights(learning_rate, momentum = 0)
    has_momentum = @weights_update && momentum > 0

    if has_momentum
      momentum_matrix = @weights_update.collect { |u| u * momentum }
    end

    @weights_update = learning_rate * (previous_layer.activation_matrix.transpose * errors)

    if has_momentum
      @weights_update = @weights_update + momentum_matrix
    end

    @weights = @weights + @weights_update
  end

  def build_weight
    @build_weight_function ? @build_weight_function.call : rand(-0.5..0.5)
  end
end