puts 'Введите первое число: '
gets.chomp.to_i

puts 'Введите второе число: '
gets.chomp.to_i

def foobar(num1, num2)
  return num2 if num1 == 20 || num2 == 20

  num1 + num2
end
