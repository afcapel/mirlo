require 'spec_helper'

describe 'ANN DSL' do
  before :each do
    @ann = Mirlo::ANN.build do
      learning_rate 0.25

      input_layer  3
      hidden_layer 3
      hidden_layer 2
      output_layer 3
    end
  end

  it "should build a multilayer perceptron" do
    expect(@ann).to be_kind_of(Mirlo::MultilayerPerceptron)
  end

  it "can set the learning rate of the neural network" do
    expect(@ann.learning_rate).to eq 0.25
  end

  it "can set the number of inputs on the input layer" do
    expect(@ann.input_layer.size).to eq 4 # 3 inputs plus the bias
  end

  it "can define hidden layers on the network" do
    expect(@ann.hidden_layers).to be_kind_of(Array)
    expect(@ann.hidden_layers.size).to eq 2

    expect(@ann.hidden_layers[0].size).to eq 3
    expect(@ann.hidden_layers[1].size).to eq 2
  end

  it "set the connections between layers" do
    expect(@ann.layers[0].next_layer).to eq @ann.layers[1]
    expect(@ann.layers[1].next_layer).to eq @ann.layers[2]
    expect(@ann.layers[2].next_layer).to eq @ann.layers[3]

    expect(@ann.layers[1].previous_layer).to eq @ann.layers[0]
    expect(@ann.layers[2].previous_layer).to eq @ann.layers[1]
    expect(@ann.layers[3].previous_layer).to eq @ann.layers[2]
  end

  it "can set the number of outputs on the output layer" do
    expect(@ann.output_layer.size).to eq 3
  end

  it "defines the weight matrices between layers" do
    weights1 = @ann.layers[1].weights
    expect(weights1.row_count).to eq 4 # 3 inputs plus the bias
    expect(weights1.column_count).to eq 3



    weights2 = @ann.layers[2].weights
    expect(weights2.row_count).to eq 3
    expect(weights2.column_count).to eq 2
  end
end