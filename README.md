# Mirlo

Some Machine Learning algorithms implemented in Ruby.

Currently implemented:

* Perceptron
* Multilayer Perceptron. Batch update of neuron weights with momentum.


## Example

```ruby

mlp = Mirlo::ANN.build do
  input_layer  2
  hidden_layer 3
  output_layer 1
end
# => #<Mirlo::MultilayerPerceptron:0x007fa0e997eff0 ...>

data_set = Mirlo::XORDataSet.new
# => #<Mirlo::XORDataSet:0x007fa0e9995430 ...>

mlp.train_until(data_set, max_error: 0.0)

mlp.classify([0,0])
# => [0]

mlp.classify([1,0])
# => [1]

mlp.classify([0,1])
# => [1]

mlp.classify([1,1])
# => [0]

```