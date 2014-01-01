module Mirlo
  class ClassifyError < StandardError; end

  class Classifier
    attr_accessor :train_set

    def train(train_set, n_iterations = Mirlo::DEFAULT_N_ITERATIONS)
      @train_set = train_set

      n_iterations.times { |i| iterate }
    end

    def train_until(train_set, max_error: 0.01, max_iterations: Mirlo::DEFAULT_N_ITERATIONS)
      @train_set = train_set

      max_iterations.times do |i|
        iterate
        test_result = test_with(train_set)

        break if test_result.mean_squared_error <= max_error

        if i == max_iterations - 1
          raise ClassifyError.new("Could not reach a standard error of #{max_error} after #{max_iterations} iterations")
        end
      end
    end

    def test_with(test_set)
      TestResult.new.tap do |tr|
        test_set.samples.each do |sample|
          prediction = classify(sample)
          tr.add(sample, prediction)
        end
      end
    end
  end
end