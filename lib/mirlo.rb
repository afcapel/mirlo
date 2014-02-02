module Mirlo
  ZERO = [0]
  ONE  = [1]
  POSITIVE = ONE
  NEGATIVE = [-1]

  DEFAULT_LEARNING_RATE = 0.05
  DEFAULT_N_ITERATIONS  = 1000

  require "gnuplot"
  require_relative "mirlo/version"
  require_relative "mirlo/plotting"
  require_relative "mirlo/extensions/matrix"
  require_relative "mirlo/sample"
  require_relative "mirlo/sample_with_bias"
  require_relative "mirlo/dataset"
  require_relative "mirlo/test_result"
  require_relative "mirlo/classifier"
  require_relative "mirlo/ann/input_layer"
  require_relative "mirlo/ann/neuron_layer"
  require_relative "mirlo/ann/hidden_layer"
  require_relative "mirlo/ann/output_layer"
  require_relative "mirlo/ann/multilayer_perceptron"
  require_relative "mirlo/ann/ann"

  Dir.glob("#{File.dirname(__FILE__)}/mirlo/classifiers/*.rb").each do |f|
    require f
  end

  Dir.glob("#{File.dirname(__FILE__)}/mirlo/datasets/*.rb").each do |f|
    require f
  end
end