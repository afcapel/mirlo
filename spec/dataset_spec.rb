require 'spec_helper'

describe 'dataset' do
  let(:samples) { [[0, 0], [0, 1], [1, 0], [1, 1]] }
  let(:targets) { [ZERO, ONE, ONE, ONE] }

  let(:dataset)       { Mirlo::Dataset.new(samples: samples, targets: targets, feature_names: ['x', 'y']) }
  let(:input_matrix)  { dataset.input_matrix  }
  let(:target_matrix) { dataset.target_matrix }

  it 'can be initialized with an array of samples and targets' do
    first_sample = dataset.samples.first

    first_sample.should be_kind_of(Mirlo::Sample)
    first_sample.target.should   == [0]
    first_sample.features.should == [-1,0,0]

    last_sample = dataset.samples.last

    last_sample.should be_kind_of(Mirlo::Sample)
    last_sample.target.should   == ONE
    last_sample.features.should == [-1,1,1]
  end

  it 'can collect the subset with a target' do
    positives = dataset.subset_with_target(ONE)
    positives.size.should eq 3
    positives.each { |s| s.target.should == ONE }
  end

  it 'can collect the values for a feature' do
    x_values = dataset.feature('x')
    x_values.should eq [0, 0, 1, 1]

    y_values = dataset.feature(1)
    y_values.should eq [0, 1, 0, 1]
  end

  it 'can create a matrix of inputs' do
    input_matrix.should be_kind_of(Matrix)
    input_matrix.should == Matrix[[-1,0,0], [-1,0,1], [-1,1,0], [-1,1,1]]
    input_matrix.row_count.should    == samples.size
    input_matrix.column_count.should == dataset.num_features
  end

  it 'can create a matrix of targets' do
    target_matrix.should be_kind_of(Matrix)
    target_matrix.should == Matrix[ZERO, ONE, ONE, ONE]
    target_matrix.row_count.should    == samples.size
    target_matrix.column_count.should == dataset.num_outputs
  end
end