class Mirlo::HiddenLayer < Mirlo::NeuronLayer
  attr_accessor :next_layer, :errors

  def calculate_errors
    error_signal = next_layer.errors * next_layer.weights.transpose

    @errors = @activations.apply_elementwise error_signal do |activation, delta|
      activation * (1.0 - activation) * delta
    end
  end
end