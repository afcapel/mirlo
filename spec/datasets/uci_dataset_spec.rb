require 'spec_helper'

describe Mirlo::UCIDataset do

  let(:dataset) { Mirlo::UCIDataset.new('iris') }

  it "loads the data in the csv file" do
    dataset.csv_path.should match %r{iris\.csv$}
    dataset.samples.size.should eq 150
  end
end