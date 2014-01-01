require 'spec_helper'

describe Mirlo::AndDataSet do

  let(:dataset) { Mirlo::AndDataSet.new }

  it 'should contain datapoints with target ONE or ZERO' do
    possible_targets = [Mirlo::ZERO, Mirlo::ONE]
    dataset.size.should == 4
    dataset.samples.each do |sample|
      possible_targets.should include sample.target
    end
  end

  it 'represents the AND logical function' do
    dataset.targets_for([0,0]).should eq [Mirlo::ZERO]
    dataset.targets_for([0,1]).should eq [Mirlo::ZERO]
    dataset.targets_for([1,0]).should eq [Mirlo::ZERO]
    dataset.targets_for([1,1]).should eq [Mirlo::ONE]
  end
end