class Mirlo::ANN
  attr_reader :ann

  def self.build(*args, &block)
    instance = new(*args)
    instance.instance_eval(&block)
    instance.ann
  end

  def initialize(*args)
    @ann = Mirlo::MultilayerPerceptron.new(*args)
  end

  def learning_rate(l_rate)
    @ann.learning_rate = l_rate
  end

  def input_layer(n_inputs)
    @ann.input_layer = Mirlo::InputLayer.new(n_inputs)
  end

  def hidden_layer(n_neurons)
    hidden_layer   = Mirlo::HiddenLayer.new(n_neurons)

    connect_with_last_layer(hidden_layer)

    @ann.hidden_layers << hidden_layer
  end

  def output_layer(n_outputs)
    output_layer = Mirlo::OutputLayer.new(n_outputs)

    connect_with_last_layer(output_layer)

    @ann.output_layer = output_layer
  end

  def connect_with_last_layer(layer)
    previous_layer = @ann.layers.last

    previous_layer.next_layer = layer
    layer.previous_layer = previous_layer
  end
end