def add_pokemon
  puts 'Сколько покемонов вы хотите добавить?'
  count = gets.chomp.to_i

  pokemons = []

  count.times do |i|
    puts "Введите имя #{i + 1}-го покемона:"
    name = gets.chomp

    puts "Введите цвет #{i + 1}-го покемона:"
    color = gets.chomp

    pokemons << { name: name, color: color }
  end

  pokemons
end

def show_pokemons(pokemons)
  puts 'Список покемонов:'
  puts pokemons.inspect
end

def main
  pokemons = add_pokemon
  show_pokemons(pokemons)
end

main
