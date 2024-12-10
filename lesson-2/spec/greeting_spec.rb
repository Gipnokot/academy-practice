# frozen_string_literal: true

require_relative '../greeting'

RSpec.describe 'greeting' do
  it '#returns the correct greeting for age < 18' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('John', 'Doe', '17')
    expect(greeting).to eq('Привет, John Doe. Тебе меньше 18 лет, но начать учиться программировать никогда не рано')
  end

  it '#returns the correct greeting for age => 18' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('John', 'Doe', '25')
    expect(greeting).to eq('Привет, John Doe. Самое время заняться делом!')
  end
end