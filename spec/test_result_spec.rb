require 'spec_helper'

describe Mirlo::TestResult do
  before do
    @test_result = Mirlo::TestResult.new([ZERO, ONE])

    positive_sample = Mirlo::Sample.new(target: ONE)
    negative_sample = Mirlo::Sample.new(target: ZERO)

    @test_result.add(positive_sample, ONE)
    @test_result.add(positive_sample, ONE)
    @test_result.add(positive_sample, ONE)

    @test_result.add(negative_sample, ZERO)
    @test_result.add(negative_sample, ZERO)
    @test_result.add(negative_sample, ZERO)

    # there are two errors classifiying positive samples

    @test_result.add(positive_sample, ZERO)
    @test_result.add(positive_sample, ZERO)
  end

  it "can show the confussion matrix" do
    @test_result.confusion_matrix(ONE, ONE).should  == 3
    @test_result.confusion_matrix(ONE, ZERO).should == 2
    @test_result.confusion_matrix(ZERO, ZERO).should == 3
    @test_result.confusion_matrix(ZERO, ONE).should  == 0
  end
end