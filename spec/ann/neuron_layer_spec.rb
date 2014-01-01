require 'spec_helper'

describe Mirlo::NeuronLayer do
  let(:previous_layer) do
     input_layer = Mirlo::InputLayer.new(2)
     input_layer.input = [0.5, 1] # A first -1 bias component will be added
     input_layer
  end

  let(:hidden_layer) do
    hidden_layer = Mirlo::NeuronLayer.new(2)
    hidden_layer.previous_layer = previous_layer
    hidden_layer
  end

  it "has a matrix of weights" do
    expect(hidden_layer.weights.shape).to eq [3, 2]
  end

  context "with given weights" do
    before :each do
      hidden_layer.build_weight_function = -> { 0.5 }
    end

    it "allows to set a function to build the weights matrix" do
      hidden_layer.weights.each do |elm|
        expect(elm).to eq 0.5
      end
    end

    it "can calculate the total input for each neuron" do
      total_inputs = hidden_layer.inputs_matrix.row(0)

      expect(total_inputs[0]).to be_within(0.00001).of 0.25
      expect(total_inputs[1]).to be_within(0.00001).of 0.25
    end

    it "can calculate the activation of each neuron" do
      activations = hidden_layer.activation_matrix.row(0)

      expect(activations[0]).to be_within(0.00001).of 1.0/(1 + Math.exp(-0.25))
      expect(activations[1]).to be_within(0.00001).of 1.0/(1 + Math.exp(-0.25))
    end
  end
end