# frozen_string_literal: true

require_relative '../pokemon'

RSpec.describe 'add_pokemon' do
  it '#adds the specified number of pokemons' do
    allow_any_instance_of(Object).to receive(:gets).and_return("2", "Pikachu", "Yellow", "Charmander", "Red")
    pokemons = add_pokemon
    
    expect(pokemons).to eq([
      { name: 'Pikachu', color: 'Yellow' },
      { name: 'Charmander', color: 'Red' }
    ])
  end

  it '#returns an array of hashes with correct data' do
    allow_any_instance_of(Object).to receive(:gets).and_return("2", "Pikachu", "Yellow", "Charmander", "Red")
    pokemons = add_pokemon

    expect(pokemons).to match_array([
      { name: 'Pikachu', color: 'Yellow' },
      { name: 'Charmander', color: 'Red' }
    ])
  end
end

RSpec.describe 'show_pokemons' do
  it '#prints the list of pokemons' do
    pokemons = [
      { name: 'Pikachu', color: 'Yellow' },
      { name: 'Charmander', color: 'Red' }
    ]
    expect { show_pokemons(pokemons) }.to output(
      "Список покемонов:\nPikachu - Yellow\nCharmander - Red\n"
    ).to_stdout
  end
end