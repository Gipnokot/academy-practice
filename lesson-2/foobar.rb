
puts "Введите первое число:"
num1 = gets.chomp.to_i

puts "Введите второе число:"
num2 = gets.chomp.to_i

def foobar(num1, num2)
  if num1 == 20 || num2 == 20
    num2
  else
    num1 + num2
  end
end

puts "Результат: #{foobar(num1, num2)}"
