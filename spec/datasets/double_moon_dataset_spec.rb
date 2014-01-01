require 'spec_helper'
require 'mirlo/datasets/double_moon_dataset'

describe Mirlo::DoubleMoonDataSet do

  let(:dataset) { Mirlo::DoubleMoonDataSet.new(n_points: 1000) }

  it 'should contain datapoints with target upper_moon or lower_moon' do
    possible_targets = [DoubleMoonDataSet::UPPER_MOON, DoubleMoonDataSet::LOWER_MOON]
    dataset.samples.size.should == 1000
    dataset.samples.each do |sample|
      sample.feature_size.should eq 3 # including bias
      sample.target.should_not be_nil
      possible_targets.should include sample.target
    end
  end
end