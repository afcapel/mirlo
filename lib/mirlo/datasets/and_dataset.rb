module Mirlo
  class ANDDataSet < Dataset
    def initialize
      @feature_names = ['x', 'y']
      @title = "Logical AND dataset"

      samples = [[0,0], [0,1], [1,0], [1,1]]
      targets = [ZERO, ZERO, ZERO, ONE]

      super(samples: samples, targets: targets)
    end
  end
end