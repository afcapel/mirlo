require 'spec_helper'

describe Mirlo::Perceptron do

  let(:perceptron) { Mirlo::Perceptron.new }

  it 'intializes the matrix of weights' do
    perceptron.train_set = Mirlo::DoubleMoonDataSet.new(n_points: 50)
    expect(perceptron.weights).to be_kind_of(Matrix)

    expect(perceptron.weights.column_count).to eq 1
    expect(perceptron.weights.row_count).to eq 3

    perceptron.weights.each do |weight|
      expect(-0.05..0.05).to include(weight)
    end
  end

  it 'can classify an OR dataset' do
    data_set   = Mirlo::OrDataSet.new

    perceptron.train(data_set)

    expect(perceptron.classify([0,0])).to eq [0]
    expect(perceptron.classify([0,1])).to eq [1]
    expect(perceptron.classify([1,0])).to eq [1]
    expect(perceptron.classify([1,1])).to eq [1]

    test_result = perceptron.test_with(data_set)
    expect(test_result.mean_squared_error).to eq 0.0
  end

  it 'can classify an AND dataset' do
    data_set  = Mirlo::AndDataSet.new

    perceptron.train(data_set)

    expect(perceptron.classify([0,0])).to eq [0]
    expect(perceptron.classify([0,1])).to eq [0]
    expect(perceptron.classify([1,0])).to eq [0]
    expect(perceptron.classify([1,1])).to eq [1]

    test_result = perceptron.test_with(data_set)
    expect(test_result.mean_squared_error).to eq 0.0
  end

  it 'can not classify an XOR dataset' do
    data_set  = Mirlo::XorDataSet.new

    perceptron.train(data_set)

    test_result = perceptron.test_with(data_set)
    expect(test_result.mean_squared_error).to be > 0.0
  end

  it 'correctly classifies a linearly separable double moon data set' do
    train_set  = Mirlo::DoubleMoonDataSet.new(distance: 10)

    perceptron.train_until(train_set, max_error: 0.0)
    test_results = perceptron.test_with(train_set)

    expect(test_results.error_percentage).to eq 0.00
  end

  it 'can not classify a non linearly separable double moon data set' do
    train_set  = Mirlo::DoubleMoonDataSet.new(distance: -2)

    expect do
      perceptron.train_until(train_set, max_error: 0.0)
    end.to raise_error(Mirlo::ClassifyError)

    test_results = perceptron.test_with(train_set)

    expect(test_results.error_percentage).to be > 0.0
  end

end