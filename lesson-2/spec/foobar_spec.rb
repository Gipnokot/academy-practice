# frozen_string_literal: true

require_relative '../foobar'

RSpec.describe 'foobar' do
  it '#returns num2 when num1 = 20' do
    expect(foobar(20, 10)).to eq(10)
  end

  it '#returns num2 when num2 = 20' do
    expect(foobar(10, 20)).to eq(20)
  end

  it '#returns num2 when num1 and num2 = 20' do
    expect(foobar(20, 20)).to eq(20)
  end

  it '#returns the sum of num1 and num2 when both are not equal to 20' do
    expect(foobar(10, 5)).to eq(15)
  end
end
