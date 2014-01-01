require 'spec_helper'

describe 'Matrix' do
  let(:matrix1) { Matrix[[0, 1], [2, 3]] }
  let(:matrix2) { Matrix[[4, 5], [6, 7]] }

  it "returns the shape of the matrices" do
    expect(matrix1.shape).to eq [2, 2]
  end

  it "allows to perform operations elementwise" do
    sum = matrix1.apply_elementwise(matrix2, &:+)
    expect(sum).to eq Matrix[[4, 6], [8, 10]]

    mult = matrix1.apply_elementwise(matrix2, &:*)
    expect(mult).to eq Matrix[[0, 5], [12, 21]]
  end
end