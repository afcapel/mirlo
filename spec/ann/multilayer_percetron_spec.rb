require 'spec_helper'

describe Mirlo::MultilayerPerceptron do

  let(:mlp) do
    Mirlo::ANN.build do
      input_layer  2
      hidden_layer 3
      output_layer 1
    end
  end

  it "can classify all data points of the OR logical function" do
    data_set = Mirlo::OrDataSet.new

    mlp.train_until(data_set, max_error: 0.0, max_iterations: 50_000)

    expect(mlp.classify([0,0])).to eq [0]
    expect(mlp.classify([0,1])).to eq [1]
    expect(mlp.classify([1,0])).to eq [1]
    expect(mlp.classify([1,1])).to eq [1]

    test_result = mlp.test_with(data_set)
    expect(test_result.mean_squared_error).to eq 0.0
  end

  it "can classify all data points of the AND logical function" do
    data_set = Mirlo::AndDataSet.new

    mlp.train_until(data_set, max_error: 0.0, max_iterations: 50_000)

    expect(mlp.classify([0,0])).to eq [0]
    expect(mlp.classify([0,1])).to eq [0]
    expect(mlp.classify([1,0])).to eq [0]
    expect(mlp.classify([1,1])).to eq [1]

    test_result = mlp.test_with(data_set)
    expect(test_result.mean_squared_error).to eq 0.0
  end

  it "can classify all data points of the XOR logical function" do
    data_set = Mirlo::XorDataSet.new

    mlp.train_until(data_set, max_error: 0.0, max_iterations: 50_000)

    expect(mlp.classify([0,0])).to eq [0]
    expect(mlp.classify([0,1])).to eq [1]
    expect(mlp.classify([1,0])).to eq [1]
    expect(mlp.classify([1,1])).to eq [0]

    test_result = mlp.test_with(data_set)
    expect(test_result.mean_squared_error).to eq 0.0
  end

end