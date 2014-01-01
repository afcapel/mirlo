module Mirlo
  class OrDataSet < Dataset
    def initialize
      @feature_names = ['x', 'y']
      @title = "Logical OR dataset"

      samples = [[0,0], [0,1], [1,0], [1,1]]
      targets = [ZERO, ONE, ONE, ONE]

      super(samples: samples, targets: targets)
    end
  end
end