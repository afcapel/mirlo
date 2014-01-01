class Mirlo::SampleWithBias < Mirlo::Sample

  def initialize(target: [], features: [])
    super(target: target)
    @features = features.dup.unshift(-1)
  end

  def [](index)
    super(index+1)
  end

  def has_features?(some_features)
    features == some_features.dup.unshift(-1)
  end

  def biased?
    true
  end
end