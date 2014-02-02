require 'spec_helper'

describe FeatureVectorization do

  # Dataset of musicians
  let(:samples) do
    # Musician, main instrument, year of birth
    [
      ['Frank Zappa', 'Guitar', 1940],
      ["Jimmi Hendrix", 'Guitar', 1942],
      ['Syd Barrett', 'Guitar', 1946],
      ['Tom Waits', 'Vocalist', 1949],
      ['Rick Astley', 'Vocalist', 1966]
    ]
  end

  let(:targets) do
    # Awesome?
    [true, true, true, true, false]
  end

  let(:dataset) do
    Mirlo::Dataset.new(samples: samples, targets: targets,
      feature_names: ['Name', 'Main instrument', 'Year of birth'])
  end

  it "transforms non numeric features to integers" do
    dataset.feature('Name').should eq [0, 1, 2, 3, 4]
    dataset.feature('Main instrument').should eq [0, 0, 0, 1, 1]
    dataset.feature('Year of birth').should eq [1940, 1942, 1946, 1949, 1966]
  end

  it "allows to vectorize any new sample" do
    dataset.vectorize(['John Coltrane', 'saxophon', 1926]).should eq [5, 2, 1926]
  end

  it "allows to query the index for a feature value" do
    dataset.index_for('Main instrument', 'Vocalist').should == 1
    dataset.index_for(1, 'Vocalist').should == 1
  end
end