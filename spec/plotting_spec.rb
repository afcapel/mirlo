require 'spec_helper'

describe 'Plotting' do
  let(:data_set)  { Mirlo::DoubleMoonDataSet.new(n_points: 1000, distance: 5) }

  it 'allows to plot a data set' do
    data_set.plot
  end
end