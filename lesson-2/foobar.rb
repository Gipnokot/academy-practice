
puts "Введите первое число: "
num1 = gets.chomp.to_i

puts "Введите второе число: "
num2 = gets.chomp.to_i

def foobar(num1, num2)
  if num1 == 20 || num2 == 20
    return num2
  else
    return num1 + num2
  end
end
