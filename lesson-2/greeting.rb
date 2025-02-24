def greeting
  puts 'Введите ваше имя: '
  first_name = gets.chomp
  puts 'Введите вашу фамилию: '
  last_name = gets.chomp
  puts 'Введите ваш возраст: '
  age = gets.chomp.to_i

  if age < 18
    "Привет, #{first_name} #{last_name}. Тебе меньше 18 лет, но начать учиться программировать никогда не рано"
  else
    "Привет, #{first_name} #{last_name}. Самое время заняться делом!"
  end
end
