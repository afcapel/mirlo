class Mirlo::TestResult
  attr_reader :n_samples

  def initialize(possible_classes = [])
    @possible_classes = possible_classes
    @confusion_matrix = Hash.new { 0 }
    @n_samples = 0
  end

  def add(sample, prediction)
    @possible_classes << sample.target unless @possible_classes.include?(sample.target)
    @confusion_matrix[[sample.target, prediction]] += 1
    @n_samples += 1
  end

  def confusion_matrix(expected, prediction)
    @confusion_matrix[[expected, prediction]]
  end

  def mean_squared_error
    errors = @confusion_matrix.collect do |results, times|
      expected, prediction = results
      error_for(expected, prediction, times)
    end

    errors.inject(:+)
  end

  def n_errors
    errors = @confusion_matrix.select do |results, times|
      expected, prediction = results
      expected != prediction
    end

    errors.collect { |results, times| times }.inject(:+)
  end

  def error_percentage
    n_errors.to_f/n_samples
  end

  private

  def error_for(expected, prediction, times)
    diffs = expected.each_with_index.collect { |expected_val, i| expected_val - prediction[i] }
    squared_errors = diffs.collect { |diff| diff ** 2 }
    squared_errors.inject(:+) * times
  end
end
