class Mirlo::Sample
  attr_reader :target, :features

  def initialize(target: [], features: [])
    @target   = target.is_a?(Array) ? target : [target]
    @features = features
  end

  def [](index)
    @features[index]
  end

  def has_features?(some_features)
    features == some_features
  end

  def feature_size
    features.size
  end

  def target_size
    target.size
  end

  def biased?
    false
  end

  def ==(other_sample)
    target    == other_sample.target &&
    features  == other_sample.features &&
    biased?   == other.biased?
  end
end
