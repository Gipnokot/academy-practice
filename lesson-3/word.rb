
def word(word1)
  word1.downcase.end_with?('cs') ? 2 ** word1.length : word1.reverse
end

def user_input_word
  puts 'Введите слово: '
  input_word = gets.chomp
    if input_word == ''
      puts 'Вы не ввели слово. Попробуйте еще раз.'
      user_input_word
    end
  puts word(input_word)
end

user_input_word
