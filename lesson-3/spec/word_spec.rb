# frozen_string_literal: true

require_relative '../word'

RSpec.describe 'word' do
  it '#returns 2 to the power of word length if word ends with "cs"' do
    expect(word('HelloCS')).to eq(128)
    expect(word('hellocs')).to eq(128)
  end

  it '#returns the reversed word if word does not end with "cs"' do
    expect(word('Ruby')).to eq('ybuR')
    expect(word('Python')).to eq('nohtyP')
  end

  it '#returns the empty string if enter is empty' do
    expect(word('')).to eq('')
  end
end
