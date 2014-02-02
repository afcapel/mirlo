require 'spec_helper'

describe Mirlo::CSVDataset do

  let(:path) { fixture_file('uci/iris.csv') }
  let(:dataset) { Mirlo::CSVDataset.new(path) }

  it "stores the path to the csv file" do
    dataset.csv_path.should match %r{fixtures\/uci\/iris\.csv$}
  end

  it "loads the feature names from the csv file" do
    dataset.feature_names.should eq [
      'sepal length in cm',
      'sepal width in cm',
      'petal length in cm',
      'petal width in cm'
    ]
  end

  it "loads the target set from the csv file" do
    dataset.target_set.should == [["Iris-setosa"], ["Iris-versicolor"], ["Iris-virginica"]]
  end

  it "loads the samples from the csv file" do
    dataset.samples.size.should eq 150

    first_sample = Mirlo::SampleWithBias.new(features: [5.1, 3.5, 1.4, 0.2], target: ['Iris-setosa'])
    last_sample  = Mirlo::SampleWithBias.new(features: [5.9, 3.0, 5.1, 1.8], target: ['Iris-virginica'])

    dataset.samples.first.should eq first_sample
    dataset.samples.last.should  eq last_sample
  end
end