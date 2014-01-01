require 'matrix'

class Matrix

  def shape
    [row_count, column_count]
  end

  #
  # Public: given two matrices of equal dimensions, apply an operation elementwise.
  #
  # Returns a new matrix with the results of the operation.
  #
  def apply_elementwise(other, &op)
    unless shape == other.shape
      raise ArgumentError.new 'To perform an element wise operation, matrices must be of the same dimension.'
    end

    new_rows = row_count.times.collect do |row|
      column_count.times.collect do |column|
        op.call(self[row, column], other[row, column])
      end
    end

    Matrix.rows(new_rows)
  end
end