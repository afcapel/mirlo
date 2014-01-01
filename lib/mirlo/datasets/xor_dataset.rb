module Mirlo
  class XorDataSet < Mirlo::Dataset
    def initialize
      @feature_names = ['x', 'y']
      @title = "Logical XOR dataset"

      samples = [[0,0], [0,1], [1,0], [1,1]]
      targets = [ZERO, ONE, ONE, ZERO]

      super(samples: samples, targets: targets)
    end
  end
end